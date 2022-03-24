require 'pathname'

def sync_folder(folder, to, recursive=false)
  to_pathname = Pathname.new(to)
  glob = recursive ? "#{folder}/**/*" : "#{folder}/*"
  paths = Dir.glob(glob, base: 'files').filter_map do |filename|
    pathname = Pathname.new(filename)

    sub_path = pathname.relative_path_from(folder)

    [pathname.to_s, to_pathname.join(sub_path).to_s]
  end

  Hash[paths]
end

def destination_for_file(file)
  return CUSTOM_DESTINATIONS[file] if CUSTOM_DESTINATIONS.has_key?(file)

  Pathname.new("~/.#{file}")
end

CUSTOM_DESTINATIONS = {
  'init.lua' => '~/.hammerspoon/init.lua',
  'gpg-agent.conf' => '~/.gnupg/gpg-agent.conf',
  'gpg.conf' => '~/.gnupg/gpg.conf',
  'Brewfile.global' => '~/.config/brew/Brewfile.global',
  'brew_bundle.sh' => '~/.config/brew/brew_bundle.sh',

  **sync_folder('nvim', '~/.config/nvim', recursive=true),
  **sync_folder('kitty', '~/.config/kitty')
}


task default: %w(sync)

task :symlinks do
  files = Dir.glob('files/**/*').filter_map do |file|
    next nil if Dir.exist?(file)

    pathname = Pathname.new(file)
    filename = pathname.relative_path_from('files')

    [File.join(Pathname.pwd(), pathname), destination_for_file(filename.to_s)]
  end

  force = ENV['OVERRIDE_SYMLINKS'] == 'true'
  flags = { force: force }
  files_existed = false
  files.each do |file|
    from, to = *file 
    from, to = [File.expand_path(from), File.expand_path(to)]
    to_folder = File.dirname(to)

    unless Dir.exists?(to_folder)
      FileUtils.mkdir_p(to_folder)
    end

    begin
      FileUtils.symlink(from, to, **flags)
    rescue Errno::EEXIST
      files_existed
      next
    end

    puts "Created symlink from #{from} to #{to}"
  end

  if files_existed
    puts "Some destination existed and were ignored. Run with OVERRIDE_SYMLINKS=true to override"
  end
end

task sync: [:pull, :symlinks]

task :pull do
  system('git pull origin master')
end

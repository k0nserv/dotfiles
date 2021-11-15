require 'pathname'


CUSTOM_DESTINATIONS = {
  'nvim/init.lua' => "$HOME/.config/nvim/init.lua",
  'init.lua' => '$HOME/.hammerspoon/init.lua',
  'gpg-agent.conf' => '$HOME/.gnupg/gpg-agent.conf',
  'gpg.conf' => '$HOME/.gnupg/gpg.conf',
  'Brewfile.global' => '$HOME/.config/brew/Brewfile.global',
  'brew_bundle.sh' => '$HOME/.config/brew/brew_bundle.sh',

  # Kitty
  'kitty.conf' => '$HOME/.config/kitty/kitty.conf',
  'solarized-dark.conf' => '$HOME/.config/kitty/solarized-dark.conf',
}

def destination_for_file(file)
  return CUSTOM_DESTINATIONS[file] if CUSTOM_DESTINATIONS.has_key?(file)

  Pathname.new("$HOME/.#{file}")
end

task default: %w(sync)

task :symlinks do
  files = Dir.glob('files/**/*').filter_map do |file|
    next nil if Dir.exist?(file)

    pathname = Pathname.new(file)
    filename = pathname.relative_path_from('files')
    p filename.to_s

    [File.join(Pathname.pwd(), pathname), destination_for_file(filename.to_s)]
  end

  p files

  force = ENV['OVERRIDE_SYMLINKS'] == 'true'
  flags = '-s'
  flags += 'f' if force
  files.each do |file|
    system("ln #{flags} \"#{file[0]}\" \"#{file[1]}\"")
  end
end

task sync: [:pull, :symlinks]

task :pull do
  system('git pull origin master')
end

require 'pathname'


CUSTOM_DESTINATIONS = {
  'init.lua' => '$HOME/.hammerspoon',
  'gpg-agent.conf' => '$HOME/.gnupg',
  'gpg.conf' => '$HOME/.gnupg',
  'Brewfile.global' => '$HOME/.config/brew',
  'brew_bundle.sh' => '$HOME/.config/brew',

  # Kitty
  'kitty.conf' => '$HOME/.config/kitty',
  'solarized-dark.conf' => '$HOME/.config/kitty',
}

def destination_for_file(file)
  return File.join(CUSTOM_DESTINATIONS[file], file) if CUSTOM_DESTINATIONS.has_key?(file)

  Pathname.new("$HOME/.#{file}")
end

task default: %w(sync)

task :symlinks do
  files = Dir.glob('files/**/*.symlink').map do |file|
    pathname = Pathname.new(file)
    filename = pathname.basename.to_s.gsub(/\.symlink/i, '')

    [Pathname.pwd() + pathname, destination_for_file(filename)]
  end

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

require 'pathname'

task default: %w(sync)

task sync: :pull do
  files = Dir.glob('files/**/*.symlink').map do |file| 
    pathname = Pathname.new(file)
    destination = Pathname.new("$HOME/.#{pathname.basename.to_s.gsub(/\.symlink/i, '')}")
    [Pathname.pwd() + pathname, destination]
  end
  
  force = ENV['OVERRIDE_SYMLINKS'] == 'true'
  flags = '-s'
  flags += 'f' if force
  files.each do |file|
    system("ln #{flags} \"#{file[0]}\" \"#{file[1]}\"")
  end
end


task :pull do
  system('git pull origin master')
end

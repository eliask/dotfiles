require 'erb'
require 'pathname'
require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE].include? file
    
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc "Update vim plugins"
task :update => [:clean, :check_dirty] do
  # Update vim plugins.
  GIT_REPOS = Dir["vim/bundle/*/.git/.."].map { |path| path = Pathname.new(path).realpath }
  GIT_REPOS.each do |repo|
    puts "Checking for updates in #{repo}..."
    command("git pull", repo)
  end
  date = `date`
  `git commit -am "Updated vim plugins: #{date}"`

  # Update oh my zsh.
  system "sh oh-my-zsh/tools/upgrade.sh"
  `git commit -am "Updated oh-my-zsh: #{date}"`
end

desc "Remove stray tag files"
task :clean do
  Dir['**/tags'].each { |file| rm file }
end

task :check_dirty do
  if !`git status`.include?('nothing to commit')
    abort "dirty index - commit first!"
  end
end

def command(cmd, dir = ".")
  Dir.chdir(dir) do
    return `#{cmd}`.chomp
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

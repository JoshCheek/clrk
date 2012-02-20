require "clrk/version"
require 'fileutils'

class CLRK
  attr_accessor :lib_dir

  def initialize(lib_dir)
    self.lib_dir = lib_dir
  end


  def initialize_dir(working_dir, stdout, stderr)
    contents = Dir['*']
    if contents.empty?
      copy_files :from => "#{lib_dir}/template/*", :to => working_dir, :stdout => stdout, :stderr => stderr
      return 0
    else
      stderr.puts "Directory is not empty, contains #{contents}"
      return 1
    end
  end

private
  
  def copy_files(options)
    FileUtils.cp_r options[:from], options[:to]
  end
end

require "clrk/version"
require "clrk/test_koan"
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

  def test(program_name=Dir.getwd)
    Dir.chdir program_name do
      `rspec spec.rb`
    end
    $?.exitstatus
  end

private
  
  def copy_files(options)
    Dir.glob(options[:from]).each do |file|
      FileUtils.cp_r file, options[:to]
    end
  end
end


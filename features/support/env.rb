$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
ROOT_DIR = File.expand_path "../../..", __FILE__

require 'pry' # just b/c you know I'll need it
require 'clrk'

Before do
  reset_working_dir
  @proving_grounds_dir = "#{File.expand_path Dir.getwd}/proving_grounds"
  @clrk_lib_dir        = "#@proving_grounds_dir/clrk_lib"
  @template_dir        = "#@clrk_lib_dir/template"
  make_dir @template_dir
end

After do
  FileUtils.rm_r @proving_grounds_dir
end

def reset_working_dir
  Dir.chdir ROOT_DIR
end

def clrk
  @clrk ||= CLRK.new(@clrk_lib_dir)
end

def make_dir(*dirnames)
  dirnames.each do |dirname|
    FileUtils.mkdir_p dirname
    FileUtils.chmod 0777, dirname
  end
end

def make_file(filename, contents='')
  File.open filename, "w" do |file|
    file << contents
  end
  File.chmod 0777, filename
end

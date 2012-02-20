$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'fakefs/safe'
require 'pry' # just b/c you know I'll need it
require 'clrk'

Before do
  FakeFS.activate!
  @clrk_lib_dir = "/clrk_lib"
  @template_dir = "/#@clrk_lib_dir/template"
  FileUtils.mkdir_p @template_dir
end

After do
  FakeFS.deactivate!
  FakeFS::FileSystem.clear
end

def clrk
  @clrk ||= CLRK.new(@clrk_lib_dir)
end

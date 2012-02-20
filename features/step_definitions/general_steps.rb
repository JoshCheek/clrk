Given 'a koan named "$name"' do |koan_name|
  @koan_name = koan_name
  @koan_dir = "#@template_dir/#@koan_name"
  FileUtils.mkdir_p "#@koan_dir/inputs"
  FileUtils.mkdir_p "#@koan_dir/outputs"
  File.open("#@koan_dir/solution", "w") { |f| }
end

Given 'the koan has an explanation' do |explanation|
  File.open("#@koan_dir/readme", "w") { |f| f << explanation }
end

Given 'the koan has an input file "$name"' do |filename, filebody|
  File.open("#@koan_dir/inputs/#{filename}", "w") { |f| f << filebody }
end

Given 'the koan has an output file "$name"' do |filename, filebody|
  File.open("#@koan_dir/outputs/#{filename}", "w") { |f| f << filebody }
end

Given 'the koan has a test' do |testbody|
  File.open("#@koan_dir/spec.rb", "w") { |f| f << testbody }
end

Given 'I am in an empty directory' do
  FileUtils.mkdir '/empty_dir'
  Dir.chdir '/empty_dir'
end

When 'I run `clrk initialize $dirname`' do |dirname|
  @stdout, @stderr = StringIO.new, StringIO.new
  @result = clrk.initialize_dir dirname, @stdout, @stderr
end

Then 'a directory "$dirname" is created in the current directory' do |dirname|
  Dir.exists?(dirname).should be_true
end

Then 'in "$dir", an empty file named "$filename" exists' do |dir, filename|
  Dir.chdir dir do
    File.exist?(filename).should be_true
    File.read(filename).should be_empty
  end
end

Then 'in "$dir", a file named "$filename" exists with contents' do |dir, filename, filebody|
  Dir.chdir dir do
    File.exist?(filename).should be_true
    File.read(filename).should == filebody
  end
end

Then 'the exit code is $exit_code' do |exit_code|
  @result.should == exit_code.to_i
end

Given 'I am in a directory with a file in it' do
  FileUtils.mkdir '/non_empty_dir'
  Dir.chdir '/non_empty_dir'
  File.open("some_file", "w") { |f| }
end

Then 'an error message is printed' do
  @stderr.string.should_not be_empty
end



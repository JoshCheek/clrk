Given 'a koan named "$name"' do |koan_name|
  @koan_name = koan_name
  @koan_dir = "#@template_dir/#@koan_name"
  make_dir "#@koan_dir/inputs", "#@koan_dir/outputs"
  make_file "#@koan_dir/solution"
end

Given 'the koan has an explanation' do |explanation|
  make_file "#@koan_dir/readme", explanation
end

Given 'the koan has an input file "$name"' do |filename, filebody|
  make_file "#@koan_dir/inputs/#{filename}", filebody
end

Given 'the koan has an output file "$name"' do |filename, filebody|
  make_file "#@koan_dir/outputs/#{filename}", filebody
end

Given 'the koan has a test' do |testbody|
  make_file "#@koan_dir/spec.rb", testbody
end

Then 'pry' do
  binding.pry
end

Given 'an example koan' do
  step %Q(a koan named "test1")
  step %Q(the koan has an explanation), <<-EOS.unindent.strip
    Some explanation.
  EOS
  step %Q(the koan has an input file "input1.txt"), <<-EOS.unindent.strip
    input line 1
    input line 2
  EOS
  step %Q(the koan has an output file "output1.txt"), <<-EOS.unindent.strip
    output line 1
    output line 2
  EOS
  step %Q(the koan has a test), <<-EOS.unindent.strip
    describe 'test1' do
      it 'converts "input" to "output" on stdin' do
        test_koan :stdin => "input1.txt", :result => "output1.txt"
      end
      
      it 'converts "input" to "output" from args' do
        test_koan :argv => "input1.txt", :result => "output1.txt"
      end
    end
  EOS
end

Given 'a passing example koan' do
  step %Q(a koan named "test1")
  step %Q(the koan has a test), <<-EOS.unindent.strip
    describe 'test1' do
      it "passes" do
        true.should be_true
      end
    end
  EOS
end

Given 'a failing example koan' do
  step %Q(a koan named "test1")
  step %Q(the koan has a test), <<-EOS.unindent.strip
    describe 'test1' do
      it "fails" do
        fail
      end
    end
  EOS
end

When "I run the koan" do
  step %Q(I run `clrk test test1`)
end

Given 'I am in an empty directory' do
  make_dir "#@proving_grounds_dir/empty_dir"
  Dir.chdir "#@proving_grounds_dir/empty_dir"
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
  make_dir "#@proving_grounds_dir/non_empty_dir"
  Dir.chdir "#@proving_grounds_dir/non_empty_dir"
  make_file "some_file"
end

Then 'an error message is printed' do
  @stderr.string.should_not be_empty
end

When 'I cd into "$dirname"' do |dirname|
  Dir.chdir dirname
end

When 'I write `$program` to "$file"' do |program, filename|
  make_file filename, program
end

When 'I run `clrk test $program`' do |program_name|
  @result = clrk.test program_name
end

When 'I run `clrk test`' do
  @result = clrk.test
end

Then /^I (pass|fail) the tests$/ do |passfail|
  @result.should == (passfail == "pass" ? 0 : 1)
end


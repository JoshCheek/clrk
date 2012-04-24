require 'spec_helper'
require 'fileutils'

describe 'the test_koan rspec helper' do
  def script
    @last_script
  end

  let :runner do
    CLRK::TestKoan.new File.dirname __FILE__ do |script|
      @last_script = script
      @result
    end
  end

  let(:working_dir)    { File.dirname File.expand_path __FILE__ }
  let(:output_file)    { working_dir + "/output"}
  let(:passing_result) { "PASSING RESULT" }
  let(:failing_result) { "FAILING RESULT" }

  before { @result = passing_result }
  before { File.open(output_file, "w") { |file| file.write passing_result } }
  after  { FileUtils.rm_f output_file }

  context 'takes the :stdin option' do
    specify "and sets the input file to the script's stdin" do
      runner.test_koan :stdin => "input1.txt", :result => output_file
      script.index("cat input1.txt |").should == 0
    end
  end

  context 'takes the :argv option' do
    specify "and sets the filenames as the script's arguments" do
      runner.test_koan :argv => "input1.txt", :result => output_file
      script.end_with?(" input1.txt").should be_true
      
      runner.test_koan :argv => %w[input1.txt input2.txt], :result => output_file
      script.end_with?(" input1.txt input2.txt").should be_true
    end
  end

  context 'takes the :result option' do
    specify 'and passes the test if they match' do
      @result = passing_result
      runner.test_koan :stdin => 'input1.txt', :result => output_file
    end

    specify "and fails the test if they don't match" do
      @result = failing_result
      expect { runner.test_koan :stdin => 'input1.txt', :result => output_file }.to raise_exception RSpec::Expectations::ExpectationNotMetError 
    end
  end

  it 'operates on the solution' do
    script_filename = working_dir + '/solution'
    script_body = 'SOME SCRIPT BODY'
    File.open(script_filename, 'w') { |file| file.write script_body }
    runner.test_koan :stdin => 'input1.txt', :result => output_file
    script.should include script_body
    FileUtils.rm_f script_filename
  end
end

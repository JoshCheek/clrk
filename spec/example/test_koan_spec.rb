require 'spec_helper'

RSpec.configure do |config|
  config.include TestKoan
end

describe 'the test_koan rspec helper' do
  before do
    TestKoan.execute_script = Proc.new do |script|
      @last_script = script
    end
  end

  def script
    @last_script
  end

  context 'takes the :stdin option' do
    specify "and sets the input file to the script's stdin" do
      test_koan :stdin => "input1.txt", :result => "output1.txt"
      script.index("cat input1.txt |").should == 0
    end
  end

  context 'takes the :argv option' do
    specify "and sets the filenames as the script's arguments" do
      test_koan :argv => "input1.txt", :result => "output1.txt"
      script.end_with?(" input1.txt").should be_true

      test_koan :argv => %w[input1.txt input2.txt], :result => "output1.txt"
      script.end_with?(" input1.txt input2.txt").should be_true
    end
  end

  context 'takes the :result option' do
    specify 'and passes the test if they match'
    specify "and fails the test if they don't match"
  end

  it 'operates on the solution'
end

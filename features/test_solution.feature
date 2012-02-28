Feature: Test solution
  A user wanting to see if their solution is valid
  will need to test their solution against the specs.

  Background:
    Given a koan named "test1"
    And the koan has an explanation
      """
      Some explanation.
      """
    And the koan has an input file "input1.txt"
      """
      input line 1
      input line 2
      """
    And the koan has an output file "output1.txt"
      """
      output line 1
      output line 2
      """
    And the koan has a test
      """
      describe 'test1' do
        it 'converts "input" to "output on stdin" do
          test_koan :stdin => "input1.txt", :result => "output1.txt"
        end
        
        it 'converts "input" to "output" from args" do
          test_koan :argv => "input1.txt", :result => "output1.txt"
        end
      end
      """
    And I am in an empty directory
    And I run `clrk initialize .`


  Scenario: Teting a valid solution from the root dir
    When I write `ruby -pe 'gsub "input", "output"'` to "test1/solution"
    And I run `clrk test test1`
    Then I pass the tests

  Scenario: Testing a valid solution from the source dir
    When I cd into "test1"
    And I write `ruby -pe 'gsub "input", "output"'` to "solution"
    And I run `clrk test`
    Then I pass the tests

  Scenario: Testing solution that can't handle stdin
    When I write `ruby -e 'puts ARGV.read.gsub "input", "output"'` to "test1/solutoin"
    And I run `clrk test test1`
    Then I fail the tests

    #  Scenario: Testing a solution that can't handle argv
    #    When I write `'ruby -e 'puts $stdin.read.gsub "input", "output"'` to "test1/solutoin"
    #    And I run `clrk test test1`
    #    Then I fail the tests
    #
    #  Scenario: Testing an incomprehensible solution
    #    When I write `lsdkfj` to "test1/solution"
    #    And I run `clrk test test1`
    #    Then I fail the tests

Feature: Initialize directory
  A user wanting to complete the koans will need to
  initialize a directory with the koans in it.

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


  Scenario: Initializing an empty directory
    Given I am in an empty directory
    When I run `clrk initialize .`
    Then a directory "test1" is created in the current directory
    And in "test1", an empty file named "solution" exists
    And in "test1", a file named "readme" exists with contents
      """
      Some explanation.
      """
    And in "test1/inputs", a file named "input1.txt" exists with contents
      """
      input line 1
      input line 2
      """
    And in "test1/outputs", a file named "output1.txt" exists with contents
      """
      output line 1
      output line 2
      """
    And the exit code is 0


  Scenario: Initializing a non-empty directory
    Given I am in a directory with a file in it
    When I run `clrk initialize .`
    Then an error message is printed
    And the exit code is 1

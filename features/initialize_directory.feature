Feature: Initialize directory
  A user wanting to complete the koans will need to
  initialize a directory with the koans in it.

  Background:
    Given an example koan    

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

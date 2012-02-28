Feature: Test solution
  A user wanting to see if their solution is valid
  will need to test their solution against the specs.

  Scenario: Testing a koan that passes
    Given a passing example koan
    And I am in an empty directory
    And I run `clrk initialize .`
    And I run the koan
    Then I pass the tests
    
  Scenario: Testing a koan that fails
    Given a failing example koan
    And I am in an empty directory
    And I run `clrk initialize .`
    And I run the koan
    Then I fail the tests

  # Scenario: Testing a valid solution from the source dir
  #   When I cd into "test1"
  #   And I write `ruby -pe 'gsub "input", "output"'` to "solution"
  #   And I run `clrk test`
  #   Then I pass the tests
  # 
  # Scenario: Testing solution that can't handle stdin
  #   When I write `ruby -e 'puts ARGV.read.gsub "input", "output"'` to "test1/solutoin"
  #   And I run `clrk test test1`
  #   Then I fail the tests

    #  Scenario: Testing a solution that can't handle argv
    #    When I write `'ruby -e 'puts $stdin.read.gsub "input", "output"'` to "test1/solutoin"
    #    And I run `clrk test test1`
    #    Then I fail the tests
    #
    #  Scenario: Testing an incomprehensible solution
    #    When I write `lsdkfj` to "test1/solution"
    #    And I run `clrk test test1`
    #    Then I fail the tests

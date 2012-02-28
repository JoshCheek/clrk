# Feature: A koan spec
#   In order to test the user's code, I'll have specs.
#   The specs require some infrastructure to not suck.
#   
#   Scenario: test_koan takes input for stdin
#     Given a koan named "test1"
#     And the koan has an input file "input1.txt"
#       """
#       input line 1
#       input line 2
#       """
#     And the koan has an output file "output1.txt"
#       """
#       output line 1
#       output line 2
#       """
#     Then pry
#     When I invoke test_koan with :stdin => "input1.txt", :result => "output1.txt"
#     # Then 
#     
#     # test_koan takes input from stdin 
#     # `#{File.read("./solution")} < #{input_filename}` == File.read(output)
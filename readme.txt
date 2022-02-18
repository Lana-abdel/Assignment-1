# Lana Abdelmohsen 
# Assignment-1
• Your VM name and password for the student1 account. 
    student2@csc415-server21.hpc.tcnj.edu, Lana2616 

• The full file pathname for the directory where your program resides on your VM. 
    all the files can be found in the Assignment-1 folder which is has the path: 
    • /home/student1/vm-csc415/Assignment-1 

• The url for the GitHub repository for this program. 
    1.URL for cloning if needed: https://github.com/Lana-abdel/Assignment-1.git
    2.URL for the actual github repo: https://github.com/Lana-abdel/Assignment-1

• Assumptions you have made: 
    1.A student who has desired 0 courses will not be placed in a course at all 
    2.A section's can_run value evaluates to false then it is implied that 
    the students in that section are no longer in it because it won't run,
    but they will not be placed in alternate course 
    3.A student will not request a course they have already taken 
    4.Students will only request courses they are eligible to take, and for which 
    they have met the prerequisites. 
    5. Students will not be registered into more than 2 courses

Instructions for running the program. 
    1. Make sure you have ruby installed (updated to ruby 3.0)
    2. If you are running this on your own machine make sure that all the input files 
    and executable files are in one directory and cd to that location
    3. If you are accessing the student1@csc415-server21.hpc.tcnj.edu VM than cd 
    to this path: /home/student1/vm-csc415/Assignment-1 
    4. Once you are in the correct path, type this in the command line: 
    ruby main.rb 
    5. The command line will then prompt you to enter the files with the student information and the course information
    6. Then the output files will be in your directory (output1.txt and output2.txt)

• Known bugs, issues or limitations. 
    There are no known bugs or issues, however there are only 3 limitations. The program does not take into account that the sections must be balanced, and 
    and this program doesn't keep track of the reason for why students did not get into a course and does not take into account if students desired number of courses is 1 everyone is placed in at least 2
     unless their desired was 0 or only 1 of the classes they listed is not full. Everything else is implemented. 
    ***note I did not keep track of all my output files because I have the File.delete?(file) everytime I ran but I included the last two output files I tested with from inputs example.csv 
    and course.csv and the output was not completely right*** 
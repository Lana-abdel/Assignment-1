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
    There are no known bugs or issues, however there are is only 1 limitation. The functionality to balance the sections
    has not been fully implemented. Students do not get enrolled to meet the max number of students that a course can take 
    but are split over the sections to meet a little over the minimum. Eventhough this is not implemented completely it has allowed for a more 
    balanced sections than was previously implemented. Everything else has been implemented. 

• Revisions (03/21/2022)

Many revisions have been made as per the feedback received from the technical review:
    1. Added functionality from the original requirements of the assignment that a student who desires one 
    course will only be placed in one if it is available
    2. Added functionality from the requirements of the assignment that a student will receive a reason why they 
    did not get into a course and if they got all their desired courses they will receieve "N/A" as a reason
    3.Attempted to add functionality to balance sections although it is not completely working as it fills up the sections until the section's length has exceeded the minimum 
    and then stops adding students. However excluding this little issue more sections can run now more students are placed in those sections
    4.Indentation issues have been fixed for easier readibility
    5.More through comments to describe the what each function does have been added before each function 
    and a new line to separate each function has also been added for easier readibility
    6. Split up many functions in easy_enroll.rb as well as the main.rb to provide a more modular and reliable approach (one function one task)
    7. Graceful error handling has been provided. After each prompt for a file name the program checks if it exits rather than checking both files at once. 
    Additionally, the program now prompts the user for another file (if an error occurs with file name input) instead of existing out of the program completely
    8. Asks for the output file names from the user instead of being hardcoded
    9. Fixed output file formats (for both files ) so that they are in a csv file format 
    10. In the student.rb file I created set values that static across all class
    instances for the priority calculations for a more secure and reliable approach
    11. I have added the structure for maintenance documentation for all source files as listed on canvas at the top 
    of each file. 


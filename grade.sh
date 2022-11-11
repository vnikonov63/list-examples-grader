# LIST OF REPOS TO CONSIDER

# 1. Just Starter code
# git@github.com:ucsd-cse15l-f22/list-methods-lab3.git

# 2. Nearly perfect code
# git@github.com:ucsd-cse15l-f22/list-methods-corrected.git

# 3. Comile error
# git@github.com:ucsd-cse15l-f22/list-methods-compile-error.git

# 4. git@github.com:ucsd-cse15l-f22/list-methods-signature.git

# 5. git@github.com:ucsd-cse15l-f22/list-methods-filename.git

# 6. git@github.com:ucsd-cse15l-f22/list-methods-nested.git

# 7. git@github.com:ucsd-cse15l-f22/list-examples-subtle.git

# While working with the server 
# use this url to test out the commands
# http://localhost:4000/grade?repo=git@github.com:ucsd-cse15l-f22/list-methods-corrected.git


# Create your grading script here
# set -e
DIRNAME="./student-submission/"

rm -rf $DIRNAME
git clone $1 $DIRNAME

echo -e "\n"

score=0
MUSTFILE="ListExamples.java"
MAXIMUMCREDIT=5
SOURCETEST="TestListExamples.java"
SOURCETESTEXEC="TestListExamples"
## note here we use .. to go up one level to reach the lib folder
CPATH=".:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar"

# Checking the existance of the file
if [ -f $DIRNAME$MUSTFILE ]
then
    echo -e "The file" $MUSTFILE "in the directory " $DIRNAME "is present [+1 point]"
    ((score++))
else 
    echo -e "The file" $MUSTFILE "in the directory " $DIRNAME "is not present [+0 points]"
    echo "Final Grade: [$score/4]"
    exit
fi

cp $SOURCETEST $DIRNAME
cd $DIRNAME
javac -cp $CPATH *.java 2> compile-err.txt

# Checking the compilation of the file
if [ $? -eq 0 ]
then
    echo "The compilation of the directory" $DIRNAME "was successfull [+1 point]"
    ((score++))
else 
    echo "The compilation of the directory" $DIRNAME "failed [+0 points]"
    echo "Final Grade: [$score/4]"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore $SOURCETESTEXEC > test-err.txt

# Checking the correctness of the file
if [ $? -eq 0 ]
then
    echo "All the tests within" $SOURCETEST "were successfull [+1 point]"
    # as we have 2 tests
    ((score=score+2))
else 
    echo "Some the tests within" $SOURCETEST "were not successfull [+0 points]"
    echo "Check test-err.txt for understanding"
    grep -h "Failures" test-err.txt
fi

echo "Final Grade: [$score/4]"

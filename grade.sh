# Create your grading script here
# set -e
DIRNAME="./student-submission/"

rm -rf $DIRNAME
git clone $1 $DIRNAME

MUSTFILE="ListExamples.java"
MAXIMUMCREDIT=5
SOURCETEST="TestListExamples.java"
CPATH=".:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar"

# Checking the existance of the file
if [ -f $DIRNAME$MUSTFILE ]
then
    echo -e "The file" $MUSTFILE "in the directory " $DIRNAME "is present [+1 point]"
else 
    echo -e "The file" $MUSTFILE "in the directory " $DIRNAME "is not present [+0 points]"
    exit
fi

cp $SOURCETEST $DIRNAME
cd $DIRNAME
javac -cp $CPATH *.java 2> compile-err.txt

# Checking the compilation of the file
if [ $? -eq 0 ]
then
    echo "The compilation of the directory" $DIRNAME "was successfull [+1 point]"
else 
    echo "The compilation of the directory" $DIRNAME "failed [+0 points]"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore $SOURCETEST > test-err.txt

# Checking the correctness of the file
if [ $? -eq 0 ]
then
    echo "All the tests within" $SOURCETEST "were successfull [+1 point]"
else 
    echo "Some the tests within" $SOURCETEST "were not successfull [+0 points]"
    grep "failure" test-err.txt
fi

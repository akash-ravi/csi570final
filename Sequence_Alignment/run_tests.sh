#!/bin/bash

# Directory containing the test cases
TEST_DIR="../CSCI570_Project/SampleTestCases"
RESULTS_DIR="../CSCI570_Project/TestResults"

# create results dir if not exists
mkdir -p "$RESULTS_DIR"

mkdir -p "$RESULTS_DIR/basic"
mkdir -p "$RESULTS_DIR/efficient"

# Python program to test
PROGRAM_BASIC="python3 basic.py"
PROGRAM_EFFICIENT="python3 efficient.py"

echo "===== Running Test Cases ====="

# Basic Tests
echo "---- Basic Tests ----"
# Loop through input files
for input in $TEST_DIR/input*.txt; do
    # Extract the number (e.g., input3 → 3)
    base=$(basename "$input")
    num=${base//input/}
    num=${num//.txt/}

    expected="$TEST_DIR/output${num}.txt"
    actual="$RESULTS_DIR/basic/output${num}.txt"

    echo -n "Test $num: "

     # Run program
    $PROGRAM_BASIC "$input" "$actual"

    # extract first line of expected and actual
    expected_first=$(sed -n '1p' "$expected")
    actual_first=$(sed -n '1p' "$actual")

    if [ "$expected_first" = "$actual_first" ]; then
        echo "PASS"
    else
        echo "FAIL ❌"
        echo "  Expected first line: $expected_first"
        echo "  Actual first line:   $actual_first"
    fi
done


# Efficient Tests
echo "---- Efficient Tests ----"
# Loop through input files
for input in $TEST_DIR/input*.txt; do
    # Extract the number (e.g., input3 → 3)
    base=$(basename "$input")
    num=${base//input/}
    num=${num//.txt/}

    expected="$TEST_DIR/output${num}.txt"
    actual="$RESULTS_DIR/efficient/output${num}.txt"

    echo -n "Test $num: "

     # Run program
    $PROGRAM_EFFICIENT "$input" "$actual"

    # extract first line of expected and actual
    expected_first=$(sed -n '1p' "$expected")
    actual_first=$(sed -n '1p' "$actual")

    if [ "$expected_first" = "$actual_first" ]; then
        echo "PASS"
    else
        echo "FAIL ❌"
        echo "  Expected first line: $expected_first"
        echo "  Actual first line:   $actual_first"
    fi
done

echo "===== Done ====="
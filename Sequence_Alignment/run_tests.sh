#!/bin/bash

# Directory containing the test cases
TEST_DIR="../CSCI570_Project/SampleTestCases"

# Python program to test
PROGRAM="python3 basic.py"

echo "===== Running Test Cases ====="

# Loop through input files
for input in $TEST_DIR/input*.txt; do
    # Extract the number (e.g., input3 → 3)
    base=$(basename "$input")
    num=${base//input/}
    num=${num//.txt/}

    expected="$TEST_DIR/output${num}.txt"
    actual="$TEST_DIR/my_output${num}.txt"

    echo -n "Test $num: "

     # Run program
    $PROGRAM "$input" "$actual"

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
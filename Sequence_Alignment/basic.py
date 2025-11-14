from utils import input_string_generator, alpha  # Import the function from utils.py
import os  # Import os for working with file paths

delta = 30  # Gap penalty

def align_sequences(seq1, seq2):
    """A simple function to align two sequences"""
    # Example alignment logic (to be implemented)
    m, n = len(seq1), len(seq2)
    # Initialize DP table
    dp = [[0 for _ in range(n + 1)] for _ in range(m + 1)]

    # Fill Base Cases
    for j in range(m + 1):
        dp[j][0] = j * delta
    for k in range(n + 1):
        dp[0][k] = k * delta

    for j in range(1, m + 1):
        for k in range(1, n + 1):
                match = dp[j-1][k-1] + alpha(seq1[j-1], seq2[k-1])
                skip2 = dp[j-1][k] + delta
                skip1 = dp[j][k-1] + delta
                dp[j][k] = min(match, skip2, skip1)
    
    print(dp[m][n])  # Print the optimal alignment cost

    # Backtrack to find the aligned sequences (not implemented here)
    aligned_seq1 = ""
    aligned_seq2 = ""
    while m > 0 and n > 0:
        if dp[m][n] == dp[m-1][n-1] + alpha(seq1[m-1], seq2[n-1]):
            aligned_seq1 = seq1[m-1] + aligned_seq1
            aligned_seq2 = seq2[n-1] + aligned_seq2
            m -= 1
            n -= 1
        elif dp[m][n] == dp[m-1][n] + delta:
            aligned_seq1 = seq1[m-1] + aligned_seq1
            aligned_seq2 = "_" + aligned_seq2
            m -= 1
        else:
            aligned_seq1 = "_" + aligned_seq1
            aligned_seq2 = seq2[n-1] + aligned_seq2
            n -= 1
    while m > 0:
        aligned_seq1 = seq1[m-1] + aligned_seq1
        aligned_seq2 = "_" + aligned_seq2
        m -= 1
    while n > 0:
        aligned_seq1 = "_" + aligned_seq1
        aligned_seq2 = seq2[n-1] + aligned_seq2
        n -= 1

    return aligned_seq1, aligned_seq2

def main():
    print("This is the main function of basic.py")

    # Get the directory of the current script
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Construct the path to the input file relative to the script's location
    input_file = os.path.join(script_dir, "..", "CSCI570_Project", "SampleTestCases", "input1.txt")

    # Call input_string_generator to get the sequences
    try:
        seq1, seq2 = input_string_generator(input_file)
        print(f"Sequence 1: {seq1}")
        print(f"Sequence 2: {seq2}")

        # Call align_sequences with the generated sequences
        aligned_seq1, aligned_seq2 = align_sequences(seq1, seq2)
        print(f"Aligned Sequence 1: {aligned_seq1}")
        print(f"Aligned Sequence 2: {aligned_seq2}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
import sys


def fairseq(numbers, N):
    S = sum(numbers)
    S_c = 0

    min_abs_diff = S

    i = 0
    j = 0
    while i < N:
        if S_c < S:
            S_c += numbers[j]
            S -= numbers[j]
            j += 1
            if j == N:
                break
        elif S_c > S:
            S_c -= numbers[i]
            S += numbers[i]
            i += 1
        else:
            min_abs_diff = 0
            break

        abs_diff = abs(S - S_c)
        if abs_diff < min_abs_diff:
            min_abs_diff = abs_diff

    return min_abs_diff


if __name__ == "__main__":
    with open(sys.argv[1], "r") as file:
        N = int(file.readline().strip())
        numbers = list(map(int, file.readline().strip().split()))

    result = fairseq(numbers, N)
    print(result)

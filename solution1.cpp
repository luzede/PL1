#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int main(int argc, char const *argv[])
{
    ifstream file(argv[1]);

    // Read the first number in the first line
    int N;
    file >> N;

    // Read the numbers in the second line and store them in a vector
    // and calculate the sum of the numbers.
    vector<int> numbers;
    int sum = 0;
    for (int i = 0, n; i < N; i++)
    {
        file >> n;
        sum += n;
        numbers.push_back(n);
    }
    file.close();

    int S = sum;
    int S_C = 0;

    int min_abs_diff = sum;
    int i = 0, j = 0;
    while (i < N)
    {
        if (S > S_C)
        {
            S -= numbers[j];
            S_C += numbers[j];
            j++;
            if (j == N) break;
        }
        else if (S < S_C)
        {
            S += numbers[i];
            S_C -= numbers[i];
            i++;
        }
        else {
            min_abs_diff = 0;
            break;
        }
        int abs_diff = abs(S - S_C);
        if (abs_diff < min_abs_diff)
        {
            min_abs_diff = abs_diff;
        }
    }

    cout << min_abs_diff << endl;

    return 0;
}

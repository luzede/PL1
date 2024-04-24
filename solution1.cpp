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

    for (int i = 0; i < N; i++)
    {
        int s = S;
        int s_c = S_C;
        for (int j = N-1; j >= i; j--) {
            int abs_diff = abs(s - s_c);
            if (abs_diff < min_abs_diff) {
                min_abs_diff = abs_diff;
            }
            s -= numbers.at(j);
            s_c += numbers.at(j);
        }
        S -= numbers.at(i);
        S_C += numbers.at(i);
    }

    cout << min_abs_diff << endl;

    return 0;
}

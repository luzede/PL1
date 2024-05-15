#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <cmath>
#include <algorithm>

using namespace std;

struct Node {
    int data;
    Node* left;
    Node* right;

    Node(int data) {
        this->data = data;
        this->left = nullptr;
        this->right = nullptr;
    }

    Node(int data, Node* left, Node* right) {
        this->data = data;
        this->left = left;
        this->right = right;
    }
};

Node* build_tree(vector<int> &vec);
void in_order (Node* root, vector<int>& vec);
int arrange(Node* root);

int main(int argc, char const *argv[])
{
    ifstream file(argv[1]);

    // Read the first number in the first line
    // int N;
    string line;
    getline(file, line);
    // N = stoi(line);
    // cout << N << endl;

    // Read the second line
    getline(file, line);
    file.close();

    // Get the length of the second line
    int len = line.length();

    // Get the number of elements in the second line
    int num_of_elements = ceil(len / 2.0);

    // Create a string stream object to read the numbers in the second line
    stringstream ss(line);

    // Read the numbers in the second line and store them in a vector
    vector<int> numbers;
    for (int i = 0, n; i < num_of_elements; i++)
    {
        ss >> n;
        numbers.push_back(n);
    }

    // Reverse the vector
    reverse(numbers.begin(), numbers.end());

    // Build the binary tree
    Node* root = build_tree(numbers);

    // Traverse the binary tree in-order and store the elements in a vector
    vector<int> in_order_vec;
    arrange(root);
    in_order(root, in_order_vec);

    for (auto it = in_order_vec.begin(); it != in_order_vec.end(); it++)
    {
        cout << *it << " ";
    }

    return 0;
}

Node* build_tree(vector<int>& vec) {
    if (vec.empty()) {
        return nullptr;
    }

    // Get the last element in the vector and remove it
    int v = vec.back();
    vec.pop_back();

    if (v == 0) return nullptr;
    else return new Node(v, build_tree(vec), build_tree(vec));
}

void in_order (Node* root, vector<int>& vec) {
    if (root->left == nullptr && root->right == nullptr) {
        vec.push_back(root->data);
        return;
    }

    if (root->left != nullptr) {
        in_order(root->left, vec);
    }

    vec.push_back(root->data);

    if (root->right != nullptr) {
        in_order(root->right, vec);
    }
}

int arrange(Node* root) {
    // If it is a leaf node, return its value
    if (root->left == nullptr && root->right == nullptr) {
        return root->data;
    }

    // If left is null, swap left and right only if right is less than root
    if (root->left == nullptr) {
        int minr = arrange(root->right);
        if (minr < root->data) {
            root->left = root->right;
            root->right = nullptr;
            return minr;
        }
        return root->data;
    }

    // If right is null, swap left and right only if left is less than root
    if (root->right == nullptr) {
        int minl = arrange(root->left);
        if (root->data < minl) {
            root->right = root->left;
            root->left = nullptr;
            return root->data;
        }
        return minl;
    }

    int minl = arrange(root->left);
    int minr = arrange(root->right);

    // If right is less than left, swap and return the value of right
    if (minr < minl) {
        Node* temp = root->right;
        root->right = root->left;
        root->left = temp;
        return minr;
    }
    // else return the value of left
    else {
        return minl;
    }
}

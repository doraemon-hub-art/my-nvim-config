#include <iostream>
#include <string>
#include <vector>

using namespace std;

int main() {
  vector<string> msg = {"hello", "world", "test"};
  for (const auto &word : msg) {
    cout << word << " ";
  }
  cout << endl;

  int a = 1;
  int b = 2;
  auto result = a + b;

  return 0;
}

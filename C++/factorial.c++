#include <iostream>
using namespace std;

int factorial(int n);

int main()
{
  int value = 0;
  cout<<"What factorial would you like to calculate?   " << endl;
  cin>>value;
  cout<< endl << factorial(value) << endl;
}

int factorial(int n)
{
  if (n==1)
  {
   return 1;
  }
  else
  {
   return n*factorial(n-1);
  }
}

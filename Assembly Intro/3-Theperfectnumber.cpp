#include <iostream>
using namespace std;

//Pure C++
bool isPerfectC(int number) {      
	int remainder;
	int sum = 0;
	for (int i = 1; i < number; i++) {
		remainder = number % i;
		if (remainder == 0) sum+=i;
	}
	if (sum == number) return true;
	else return false;
}

//C++ & Assembly
bool isPerfectA(int number) {
	int sum;

	_asm MOV ECX , 0
	_asm MOV EBX , 1
	_asm {

	forLoop:
		MOV EDX , 0
		MOV EAX , number
		DIV EBX
		CMP EDX , 0
		JE SUM
		INC EBX
		JMP forLoop


		SUM:
		CMP EBX , number
		JE FINISH
		ADD ECX , EBX
		INC EBX
		JMP forLoop


		FINISH:
	}
	_asm MOV sum , ECX
	if (sum == number) return true;
	else return false;

}




//C++ WITH LOOPS & Assembly 
bool isPerfectL(int number) {
	_asm MOV ECX , 0
	int sum;
	for (int i = 1; i < number; i++) {
		_asm {
			MOV EBX , i
			MOV EDX, 0
			MOV EAX , number
			DIV EBX
			CMP EDX , 0
			JE SUM
			JMP FINISH

			SUM :
			ADD ECX, EBX

			FINISH :
		}
	}
	_asm MOV sum, ECX
	if (sum == number) return true;
	else return false;

}





int main()
{
   
	int number;
	while (true) {

		cout << "Please Enter A Number ||0 For Exit ||Else To Check If It's Perfect||\n";
		cin >> number;
		if (number == 0) break;
		if (isPerfectL(number)) cout << "\t\tPERFECT NUMBER\n";
		else cout << "\t\tNOT A PERFECT NUMBER\n";
	}


	
}


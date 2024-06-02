#include <stdio.h>
#include <unistd.h>

//gcc -g -m32 timestamp.s integral.s integralv2.s measureTime.c -o measureIntegralTime
// ./measureIntegralTime



unsigned long long timestamp();
void integral();
void integralv2();
int main() {
	unsigned long long tstamp1, tstamp2, tstamp3;

	tstamp1 = timestamp();
	integral();
	tstamp2 = timestamp();
	integralv2();
	tstamp3 = timestamp();
	printf("Time 1: %llu\n", tstamp2 - tstamp1);
	printf("Time 2: %llu\n", tstamp3 - tstamp2);

	return 0;
}

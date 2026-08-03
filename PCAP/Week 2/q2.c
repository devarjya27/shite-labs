#include <stdio.h>
#include <omp.h>

int calc(int i, int x)
{
	return i*x;
}
int main()
{
	printf("Reg No: 240968040, Name: Devarjya\n");
	int x = 2;
	#pragma omp parallel
	{
		int tid = omp_get_thread_num();
		int result = calc(x, tid);
		
		printf("i = %d, x = %d, result = %d\n", x, tid, result);
	}
	return 0;
}


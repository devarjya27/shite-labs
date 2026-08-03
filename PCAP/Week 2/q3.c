#include <stdio.h>
#include <omp.h>

int main()
{
	int sum_even=0;
	int sum_odd=0; int n;
	
	printf("Reg No: 240968040, Name: Devarjya\n");
	printf("Enter size of array\n");
	scanf("%d", &n);
	int a[n];
	printf("Enter elements:\n");
	
	for (int i=0; i<n; i++)
	{
		scanf("%d", &a[i]);
	}
	omp_set_num_threads(2);
	
	#pragma omp parallel shared(a, n, sum_even, sum_odd)
	{
		int tid = omp_get_thread_num();
		if(tid==0)
		{
			for(int i=0; i<n; i++)
			if(a[i]%2==0) sum_even += a[i];
			
			printf("Thread %d calculated even sum %d\n", tid, sum_even);
		}
		
		if(tid==1)
		{
			for(int i=0; i<n; i++)
			if(a[i]%2!=0) sum_odd += a[i];
			
			printf("Thread %d calculated odd sum %d\n", tid, sum_odd);
		}
	}
	return 0;
}

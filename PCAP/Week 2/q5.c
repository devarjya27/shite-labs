#include <stdio.h>
#include <omp.h>

int is_prime(int n) {
    if (n <= 1) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int main() {
    int start, end;
    
    printf("Reg No: 240968040, Name: Devarjya\n");

    printf("Enter start and end: ");
    scanf("%d %d", &start, &end);

    printf("Primes:\n");

    #pragma omp parallel for 
        
    for (int i = start; i <= end; i++) {
    int tid = omp_get_thread_num();
        if (is_prime(i)) {
        printf("%d found %d\n", tid, i);
        }
    }

    return 0;
}

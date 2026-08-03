#include <stdio.h>
#include <omp.h>

long long fibonacci(int n) {
    if (n <= 0) return 0;
    if (n == 1) return 1;
    long long a = 0, b = 1, c = 0;
    for (int i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    return c;
}

int main() {
    int A[] = {10, 13, 5, 6};
    int n = 4;
    long long F[4];
    double start, time_taken;

    printf("Reg No: 240968040, Name: Devarjya\n");
    printf("Array A: {10, 13, 5, 6}\n\n");
    
    start = omp_get_wtime();

    #pragma omp parallel for
    for (int i = 0; i < n; i++) {
        int tid = omp_get_thread_num();
        F[i] = fibonacci(A[i]);
        
            printf("Thread %d computed F[%d] = %lld for A[%d] = %d\n. Total threads: %d", tid, i, F[i], i, A[i], omp_get_num_threads());
    }
    
    time_taken = omp_get_wtime() - start;
    printf("\nTime taken: %lf seconds\n", time_taken);

    printf("\nFinal Fibonacci Array F: {");
    for (int i = 0; i < n; i++) {
        printf("%lld%s", F[i], (i == n - 1) ? "" : ", ");
    }
    printf("}\n");

    return 0;
}

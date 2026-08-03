#include <stdio.h>
#include <omp.h>

int main() {

    // Illustrates the fork-join pattern using OpenMP's parallel directive.
    printf("Reg No: 20968040, Name: Devarjya\n");
    printf("Fork-Join\n");
    #pragma omp parallel
    {
        printf("Thread %d inside parallel region\n", omp_get_thread_num());
    }
    printf("\n");
    
    // Illustrates the fork-join pattern using multiple OpenMP parallel directives and changing the number of threads two ways
    printf("Changing Thread Counts\n");
    
    #pragma omp parallel num_threads(3)
    {
        #pragma omp single
        printf("1. Using num_threads(3) clause: Active threads = %d\n", omp_get_num_threads());
    }

    omp_set_num_threads(2);
    #pragma omp parallel
    {
        #pragma omp single
        printf("2. Using omp_set_num_threads(2): Active threads = %d\n", omp_get_num_threads());
    }
    printf("\n");
    
    // Illustrates the single-program-multiple-data (SPMD) pattern using two basic OpenMP commands
    printf("SPMD Pattern\n");
    #pragma omp parallel num_threads(4)
    {
        int tid = omp_get_thread_num();
        printf("SPMD: Hello from thread %d doing its own task.\n", tid);
    }

    return 0;
}

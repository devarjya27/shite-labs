#include <stdio.h>
#include <omp.h>

int main() {
    double a, b;
    printf("Reg No: 240968040, Name: Devarjya\n");

    printf("Enter two numbers: ");
    scanf("%lf %lf", &a, &b);

    #pragma omp parallel num_threads(4)
    {
        int tid = omp_get_thread_num();

        if (tid == 0) {
            printf("Addition: %.2lf (Executed by thread %d)\n", a + b, tid);
        } else if (tid == 1) {
            printf("Subtraction: %.2lf (Executed by thread %d)\n", a - b, tid);
        } else if (tid == 2) {
            printf("Multiplication: %.2lf (Executed by thread %d)\n", a * b, tid);
        } else if (tid == 3) {
            printf("Division: %.2lf (Executed by thread %d)\n", a / b, tid);
        }
    }

    return 0;
}

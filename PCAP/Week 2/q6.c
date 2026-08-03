#include <stdio.h>
#include <string.h>
#include <omp.h>

int main() {
    char str[] = "Hello Everyone";
    printf("Reg No: 240968040, Name: Devarjya\n");
    printf("Original string: %s\n", str);

    int len = strlen(str);

    omp_set_num_threads(len);

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        
        if (tid < len) {
            char c = str[tid];
            if (c >= 'a' && c <= 'z') {
                str[tid] = c - 32;
            } else if (c >= 'A' && c <= 'Z') {
                str[tid] = c + 32;
            }
            
        printf("Thread %d toggled character at index %d\n", tid, tid);
       
        }
    }

    printf("Output: %s\n", str);
    return 0;
}

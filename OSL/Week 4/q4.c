#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

int *arr, n;

// Thread 1: Bubble Sort
void* bubble_sort(void* arg) {
    clock_t start = clock();
    int *temp = malloc(n * sizeof(int));
    for(int i=0; i<n; i++) temp[i] = arr[i]; 

    for (int i = 0; i < n-1; i++)
        for (int j = 0; j < n-i-1; j++)
            if (temp[j] > temp[j+1]) {
                int t = temp[j]; temp[j] = temp[j+1]; temp[j+1] = t;
            }

    clock_t end = clock();
    printf("Bubble Sort took: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
    free(temp);
    pthread_exit(NULL);
}

// Thread 2: Selection Sort
void* selection_sort(void* arg) {
    clock_t start = clock();
    int *temp = malloc(n * sizeof(int));
    for(int i=0; i<n; i++) temp[i] = arr[i];

    for (int i = 0; i < n-1; i++) {
        int min = i;
        for (int j = i+1; j < n; j++)
            if (temp[j] < temp[min]) min = j;
        int t = temp[min]; temp[min] = temp[i]; temp[i] = t;
    }

    clock_t end = clock();
    printf("Selection Sort took: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
    
    for(int i=0; i<n; i++) arr[i] = temp[i]; 
    
    free(temp);
    pthread_exit(NULL);
}

int main(int argc, char *argv[]) {
    if (argc < 2) return 1;

    n = atoi(argv[1]);
    arr = malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) arr[i] = atoi(argv[i+2]);

    pthread_t t1, t2;
    pthread_create(&t1, NULL, bubble_sort, NULL);
    pthread_create(&t2, NULL, selection_sort, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    printf("Final Sorted Array: ");
    for (int i = 0; i < n; i++) printf("%d ", arr[i]);
    printf("\n");

    free(arr);
    return 0;
}

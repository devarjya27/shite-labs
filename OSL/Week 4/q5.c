#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

int arr[100];
int n;

void* runner(void* arg) {
    arr[0] = 0; arr[1] = 1;
    for (int i = 2; i < n; i++)
        arr[i] = arr[i-1] + arr[i-2];
    pthread_exit(0);
}

int main(int argc, char *argv[]) {
    n = atoi(argv[1]);
    pthread_t tid;

    pthread_create(&tid, NULL, runner, NULL);
    pthread_join(tid, NULL);

    printf("Fibonacci sequence: ");
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");

    return 0;
}

#include <stdio.h>
#include <stdlib.h>


void sort(int arr[], int n) {
    int temp;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

int main() {
    int n, head, disk_size, i, j;
    int total_movement = 0;

    printf("Enter number of requests: ");
    scanf("%d", &n);
    int req[n];
    printf("Enter request sequence: ");
    for (i = 0; i < n; i++) scanf("%d", &req[i]);
    printf("Enter initial head position: ");
    scanf("%d", &head);
    printf("Enter total disk size: ");
    scanf("%d", &disk_size);

   
    int curr = head;
    total_movement = 0;
    for (i = 0; i < n; i++) {
        total_movement += abs(req[i] - curr);
        curr = req[i];
    }
    printf("\n(i)   FCFS Total Movements: %d", total_movement);

    // --- (ii) SSTF ---
    total_movement = 0;
    curr = head;
    int visited[n];
    for (i = 0; i < n; i++) visited[i] = 0;
    for (i = 0; i < n; i++) {
        int min = 1e9, index = -1;
        for (j = 0; j < n; j++) {
            if (!visited[j] && abs(req[j] - curr) < min) {
                min = abs(req[j] - curr);
                index = j;
            }
        }
        total_movement += min;
        curr = req[index];
        visited[index] = 1;
    }
    printf("\n(ii)  SSTF Total Movements: %d", total_movement);


    int sorted_req[n];
    for(i=0; i<n; i++) sorted_req[i] = req[i];
    sort(sorted_req, n);


    total_movement = head + sorted_req[n-1]; 
    printf("\n(iii) SCAN Total Movements: %d", total_movement);


    int max_val_below_head = 0;
    for(i=0; i<n; i++) {
        if(sorted_req[i] < head) max_val_below_head = sorted_req[i];
    }
    total_movement = (disk_size - 1 - head) + (max_val_below_head - 0);
    printf("\n(iv)  C-SCAN Total Movements: %d\n", total_movement);

    return 0;
}

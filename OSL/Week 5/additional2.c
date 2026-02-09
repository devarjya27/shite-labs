#include <stdio.h>
#include <stdbool.h>

struct Process {
    int id;
    int at;  // Arrival Time
    int bt;  // Burst Time
    int ct;  // Completion Time
    int wt;  // Waiting Time
    int tat; // Turnaround Time
};

int main() {
    int n = 4;
    struct Process p[] = {
        {1, 0, 60},
        {2, 3, 30},
        {3, 4, 40},
        {4, 9, 10}
    };

    bool is_completed[4] = {false};
    int completed = 0;
    int currentTime = 0;
    float total_wt = 0, total_tat = 0;

    while (completed < n) {
        int idx = -1;
        int min_bt = 1e9; // Initialize with a very large value

        // Search for the process with the shortest burst time among arrived ones
        for (int i = 0; i < n; i++) {
            if (p[i].at <= currentTime && !is_completed[i]) {
                if (p[i].bt < min_bt) {
                    min_bt = p[i].bt;
                    idx = i;
                }
                // Tie-breaker: If burst times are same, pick the one that arrived first
                if (p[i].bt == min_bt) {
                    if (idx != -1 && p[i].at < p[idx].at) {
                        idx = i;
                    }
                }
            }
        }

        if (idx != -1) {
            // Process the shortest job found
            currentTime += p[idx].bt;
            p[idx].ct = currentTime;
            p[idx].tat = p[idx].ct - p[idx].at;
            p[idx].wt = p[idx].tat - p[idx].bt;
            
            total_wt += p[idx].wt;
            total_tat += p[idx].tat;
            is_completed[idx] = true;
            completed++;
        } else {
            // If no process has arrived, move time forward
            currentTime++;
        }
    }

    // Output table
    printf("PID\tAT\tBT\tCT\tWT\tTAT\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", 
               p[i].id, p[i].at, p[i].bt, p[i].ct, p[i].wt, p[i].tat);
    }

    printf("\nAverage Waiting Time = %.2f", total_wt / n);
    printf("\nAverage Turnaround Time = %.2f\n", total_tat / n);

    return 0;
}

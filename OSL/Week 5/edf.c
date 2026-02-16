#include <stdio.h>

struct Process {
    char id[5];
    int arrival, burst, deadline, remaining_burst;
    int finish, waiting, turnaround;
    int completed;
};

int main() {
    // Format: {ID, Arrival, Burst, Deadline, Remaining, Finish, WT, TAT, Completed}
    struct Process p[] = {
        {"P1", 0, 60, 100, 60, 0, 0, 0, 0},
        {"P2", 3, 30, 70,  30, 0, 0, 0, 0},
        {"P3", 4, 40, 50,  40, 0, 0, 0, 0},
        {"P4", 9, 10, 120, 10, 0, 0, 0, 0}
    };

    int n = 4;
    int current_time = 0, completed_count = 0;
    float total_wt = 0, total_tat = 0;

    while (completed_count < n) {
        int best_p = -1;
        int min_deadline = 9999;

        // Find arrived process with the earliest deadline
        for (int i = 0; i < n; i++) {
            if (p[i].arrival <= current_time && p[i].completed == 0) {
                if (p[i].deadline < min_deadline) {
                    min_deadline = p[i].deadline;
                    best_p = i;
                }
            }
        }

        if (best_p != -1) {
            p[best_p].remaining_burst--;
            current_time++;

            if (p[best_p].remaining_burst == 0) {
                p[best_p].finish = current_time;
                p[best_p].turnaround = p[best_p].finish - p[best_p].arrival;
                p[best_p].waiting = p[best_p].turnaround - p[best_p].burst;
                p[best_p].completed = 1;
                completed_count++;
            }
        } else {
            current_time++; // CPU Idle
        }
    }

    // Results Table
    printf("Process\tAT\tBT\tDT\tFT\tWT\tTAT\n");
    for (int i = 0; i < n; i++) {
        total_wt += p[i].waiting;
        total_tat += p[i].turnaround;
        printf("%s\t%d\t%d\t%d\t%d\t%d\t%d\n", 
                p[i].id, p[i].arrival, p[i].burst, p[i].deadline, 
                p[i].finish, p[i].waiting, p[i].turnaround);
    }

    printf("\nAverage Waiting Time: %.2f", total_wt / n);
    printf("\nAverage Turnaround Time: %.2f\n", total_tat / n);

    return 0;
}

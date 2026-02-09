#include <stdio.h>
#include <stdbool.h>
#include <limits.h>


int pids[] = {1, 2, 3, 4};
int at[] = {0, 3, 4, 9};
int bt[] = {60, 30, 40, 10};
int pri[] = {3, 2, 1, 4}; // Priority for P1, P2, P3, P4
int n = 4;

// 1. FCFS Algorithm
void runFCFS() {
    printf("\n--- FCFS Scheduling ---\n");
    int wt[n], tat[n], ct[n];
    int current_time = 0;

    for (int i = 0; i < n; i++) {
        if (current_time < at[i]) current_time = at[i];
        wt[i] = current_time - at[i];
        ct[i] = current_time + bt[i];
        tat[i] = ct[i] - at[i];
        current_time = ct[i];
    }

    float twt = 0, ttat = 0;
    printf("PID\tAT\tBT\tCT\tWT\tTAT\n");
    for (int i = 0; i < n; i++) {
        twt += wt[i]; ttat += tat[i];
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", pids[i], at[i], bt[i], ct[i], wt[i], tat[i]);
    }
    printf("Avg WT: %.2f | Avg TAT: %.2f\n", twt/n, ttat/n);
    
    printf("Gantt Chart for FCFS\n");
printf("0          60          90         130        140\n");
printf("|   P1     |    P2     |    P3     |    P4     |\n");
printf("------------------------------------------------\n");
printf("     60s         30s         40s         10s\n");
}




// 2. SRTF Algorithm (Preemptive SJF)
void runSRTF() {
    printf("\n--- SRTF Scheduling ---\n");
    int rt[n], wt[n], tat[n], ct[n];
    for(int i=0; i<n; i++) rt[i] = bt[i];

    int completed = 0, time = 0, min_rt = INT_MAX, shortest = 0;
    bool found = false;

    while (completed != n) {
        for (int i = 0; i < n; i++) {
            if ((at[i] <= time) && (rt[i] < min_rt) && rt[i] > 0) {
                min_rt = rt[i];
                shortest = i;
                found = true;
            }
        }

        if (!found) { time++; continue; }

        rt[shortest]--;
        min_rt = (rt[shortest] == 0) ? INT_MAX : rt[shortest];

        if (rt[shortest] == 0) {
            completed++;
            found = false;
            ct[shortest] = time + 1;
            tat[shortest] = ct[shortest] - at[shortest];
            wt[shortest] = tat[shortest] - bt[shortest];
        }
        time++;
    }

    float twt = 0, ttat = 0;
    printf("PID\tAT\tBT\tCT\tWT\tTAT\n");
    for (int i = 0; i < n; i++) {
        twt += wt[i]; ttat += tat[i];
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", pids[i], at[i], bt[i], ct[i], wt[i], tat[i]);
    }
    printf("Avg WT: %.2f | Avg TAT: %.2f\n", twt/n, ttat/n);
    
    printf("Gantt Chart for SRTF\n");
printf("0   3     9    19         43         83         140\n");
printf("|P1 | P2  | P4  |   P2    |    P3    |    P1     |\n");
printf("--------------------------------------------------\n");
printf("3s   6s    10s     24s        40s        57s\n");
}




// 3. Round Robin Algorithm (Quantum 10)
void runRR(int q) {
    printf("\n--- Round Robin (Q=%d) ---\n", q);
    int rem_bt[n], wt[n], tat[n], ct[n], queue[100];
    bool inQ[n];
    int f = 0, r = 0, completed = 0, t = 0;

    for(int i=0; i<n; i++) { rem_bt[i] = bt[i]; inQ[i] = false; }

    while (completed < n) {
        for(int i=0; i<n; i++) {
            if(at[i] <= t && !inQ[i]) { queue[r++] = i; inQ[i] = true; }
        }

        if (f == r) { t++; continue; }

        int i = queue[f++];
        int exec = (rem_bt[i] > q) ? q : rem_bt[i];
        t += exec;
        rem_bt[i] -= exec;

        for(int j=0; j<n; j++) {
            if(at[j] <= t && !inQ[j]) { queue[r++] = j; inQ[j] = true; }
        }

        if(rem_bt[i] > 0) queue[r++] = i;
        else { completed++; ct[i] = t; tat[i] = ct[i] - at[i]; wt[i] = tat[i] - bt[i]; }
    }

    float twt = 0, ttat = 0;
    printf("PID\tAT\tBT\tCT\tWT\tTAT\n");
    for (int i = 0; i < n; i++) {
        twt += wt[i]; ttat += tat[i];
        printf("%d\t%d\t%d\t%d\t%d\t%d\n", pids[i], at[i], bt[i], ct[i], wt[i], tat[i]);
    }
    printf("Avg WT: %.2f | Avg TAT: %.2f\n", twt/n, ttat/n);
    
    printf("Gantt Chart for Round Robin\n");
printf("0    10    20    30    40    50    60    70    80    90    100   110   120   130   140\n");
printf("| P1 | P2 | P3 | P4 | P1 | P2 | P3 | P1 | P2 | P3 | P1 | P3 | P1 | P1 |\n");
printf("-------------------------------------------------------------------------------\n");
printf("  10   10    10    10   10    10    10    10    10    10    10    10    10    10\n");
}




// 4. Non-Preemptive Priority
void runPriority() {
    printf("\n--- Non-Preemptive Priority ---\n");
    bool done[n];
    int ct[n], wt[n], tat[n], completed = 0, time = 0;
    for(int i=0; i<n; i++) done[i] = false;

    while(completed < n) {
        int idx = -1, max_p = -1;
        for(int i=0; i<n; i++) {
            if(at[i] <= time && !done[i] && pri[i] > max_p) {
                max_p = pri[i]; idx = i;
            }
        }
        if(idx != -1) {
            time += bt[idx];
            ct[idx] = time;
            tat[idx] = ct[idx] - at[idx];
            wt[idx] = tat[idx] - bt[idx];
            done[idx] = true; completed++;
        } else time++;
    }

    float twt = 0, ttat = 0;
    printf("PID\tPri\tAT\tBT\tCT\tWT\tTAT\n");
    for (int i = 0; i < n; i++) {
        twt += wt[i]; ttat += tat[i];
        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\n", pids[i], pri[i], at[i], bt[i], ct[i], wt[i], tat[i]);
    }
    printf("Avg WT: %.2f | Avg TAT: %.2f\n", twt/n, ttat/n);
    
    printf("Gantt Chart for non preemptive priority\n");
printf("0          60         70         100        140\n");
printf("|    P1    |    P4    |    P2     |    P3     |\n");
printf("------------------------------------------------\n");
printf(" 60s        10s        30s         40s\n");
printf(" (Pri: 3)   (Pri: 4)   (Pri: 2)    (Pri: 1)\n");
}


int main() {
    int choice;
    while(1) {
        printf("\n1. FCFS\n2. SRTF\n3. Round Robin (Q=10)\n4. Priority (Non-Preemptive)\n5. Exit\nEnter Choice: ");
        scanf("%d", &choice);
        switch(choice) {
            case 1: runFCFS(); break;
            case 2: runSRTF(); break;
            case 3: runRR(10); break;
            case 4: runPriority(); break;
            case 5: return 0;
            default: printf("Invalid Choice!\n");
        }
    }
}

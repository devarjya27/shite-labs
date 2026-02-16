#include <stdio.h>
#include <math.h>

/**
 * Rate-Monotonic Scheduling Simulation
 * P1: Period = 50, Burst = 20
 * P2: Period = 100, Burst = 35
 */

int main() {
    // 1. Task Parameters
    int p1_period = 50, p1_burst = 20;
    int p2_period = 100, p2_burst = 35;
    int n = 2; // Number of tasks

    // 2. Calculate CPU Utilization
    float u1 = (float)p1_burst / p1_period;
    float u2 = (float)p2_burst / p2_period;
    float total_utilization = u1 + u2;

    // Formula: n * (2^(1/n) - 1)
    float bound = n * (pow(2, 1.0 / n) - 1);

    printf("--- RMS Analysis ---\n");
    printf("Utilization P1: %.2f\n", u1);
    printf("Utilization P2: %.2f\n", u2);
    printf("Total Utilization: %.2f\n", total_utilization);
    printf("RMS Schedulability Bound: %.2f\n\n", bound);

    if (total_utilization > 1.0) {
        printf("System is NOT schedulable (Utilization > 100%%).\n");
        return 0;
    } else if (total_utilization <= bound) {
        printf("System is GUARANTEED to be schedulable (Total U <= Bound).\n");
    } else {
        printf("System MAY be schedulable (Total U > Bound but <= 1.0).\n");
    }

    printf("\n--- Starting Simulation ---\n");
    printf("Time\tTask\tP1_Rem\tP2_Rem\tNote\n");
    printf("--------------------------------------------\n");

    int p1_remain = 0;
    int p2_remain = 0;
    int total_time = 100; // Simulate for one full cycle of the longest period

    for (int t = 0; t <= total_time; t++) {
        // Task Arrival Logic
        if (t % p1_period == 0 && t < total_time) {
            p1_remain = p1_burst;
        }
        if (t % p2_period == 0 && t < total_time) {
            p2_remain = p2_burst;
        }

        // Output Status at current time tick
        if (p1_remain > 0) {
            printf("%d\tP1\t%d\t%d\tP1 is running\n", t, p1_remain, p2_remain);
            p1_remain--;
        } else if (p2_remain > 0) {
            printf("%d\tP2\t0\t%d\tP2 is running\n", t, p2_remain);
            p2_remain--;
        } else {
            printf("%d\tIDLE\t0\t0\tCPU is waiting\n", t);
        }
        
        if (t == 50) {
        }
    }

    return 0;
}

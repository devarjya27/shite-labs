#include <stdio.h>
#include <stdbool.h>

#define MAX_P 10
#define MAX_R 3 

void printResources(int arr[])
{
    printf("A=%d B=%d C=%d\n", arr[0], arr[1], arr[2]);
}

void calculateNeed(int n, int allocation[][MAX_R], int max[][MAX_R], int need[][MAX_R])
{
    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < MAX_R; j++)
        {
            need[i][j] = max[i][j] - allocation[i][j];
        }
    }
}

bool isSafe(int n, int available[], int allocation[][MAX_R], int need[][MAX_R])
{
    int work[MAX_R];
    bool finish[MAX_P] = {false};
    int safeSeq[MAX_P];

    for(int i = 0; i < MAX_R; i++)
        work[i] = available[i];

    int count = 0;

    while(count < n)
    {
        bool found = false;

        for(int i = 0; i < n; i++)
        {
            if(!finish[i])
            {
                bool possible = true;

                for(int j = 0; j < MAX_R; j++)
                {
                    if(need[i][j] > work[j])
                    {
                        possible = false;
                        break;
                    }
                }

                if(possible)
                {
                    for(int j = 0; j < MAX_R; j++)
                        work[j] += allocation[i][j];

                    safeSeq[count++] = i;
                    finish[i] = true;
                    found = true;
                }
            }
        }

        if(!found)
        {
            printf("\nSystem is NOT in Safe State (Deadlock Possible)\n");
            return false;
        }
    }

    printf("\nSystem is in SAFE STATE.\nSafe Sequence: ");
    for(int i = 0; i < n; i++)
        printf("P%d ", safeSeq[i]);
    printf("\n");

    return true;
}

int main()
{
    int n;
    int total[MAX_R] = {10, 5, 7};   
    int allocation[MAX_P][MAX_R];
    int max[MAX_P][MAX_R];
    int need[MAX_P][MAX_R];
    int available[MAX_R];

    printf("Enter number of processes: ");
    scanf("%d", &n);

    printf("\nEnter Allocation Matrix (A B C):\n");
    for(int i = 0; i < n; i++)
    {
        printf("For P%d: ", i);
        for(int j = 0; j < MAX_R; j++)
            scanf("%d", &allocation[i][j]);
    }

    printf("\nEnter Max Matrix (A B C):\n");
    for(int i = 0; i < n; i++)
    {
        printf("For P%d: ", i);
        for(int j = 0; j < MAX_R; j++)
            scanf("%d", &max[i][j]);
    }

    for(int j = 0; j < MAX_R; j++)
    {
        int sum = 0;
        for(int i = 0; i < n; i++)
            sum += allocation[i][j];

        available[j] = total[j] - sum;
    }

    calculateNeed(n, allocation, max, need);

    printf("\nAvailable Resources: ");
    printResources(available);

    printf("\nNeed Matrix:\n");
    for(int i = 0; i < n; i++)
    {
        printf("For P%d: ", i);
        printResources(need[i]);
    }

    isSafe(n, available, allocation, need);

    return 0;
}

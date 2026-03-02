#include <stdio.h>
#include <stdbool.h>

#define N 5  
#define M 3 


void printABC(int arr[])
{
    printf("A=%d B=%d C=%d\n", arr[0], arr[1], arr[2]);
}

void detectDeadlock(int available[M], int allocation[N][M], int request[N][M])
{
    int work[M];
    bool finish[N];
    int deadlock = 0;

    for(int i = 0; i < M; i++)
        work[i] = available[i];

    for(int i = 0; i < N; i++)
    {
        bool zeroAllocation = true;

        for(int j = 0; j < M; j++)
        {
            if(allocation[i][j] != 0)
            {
                zeroAllocation = false;
                break;
            }
        }

        if(zeroAllocation)
            finish[i] = true;
        else
            finish[i] = false;
    }

    // Step 2 & 3
    bool found;
    do
    {
        found = false;

        for(int i = 0; i < N; i++)
        {
            if(finish[i] == false)
            {
                bool possible = true;

                for(int j = 0; j < M; j++)
                {
                    if(request[i][j] > work[j])
                    {
                        possible = false;
                        break;
                    }
                }

                if(possible)
                {
                    for(int j = 0; j < M; j++)
                        work[j] += allocation[i][j];

                    finish[i] = true;
                    found = true;
                }
            }
        }

    } while(found);

    for(int i = 0; i < N; i++)
    {
        if(finish[i] == false)
        {
            deadlock = 1;
            printf("Process P%d is Deadlocked\n", i);
        }
    }

    if(deadlock == 0)
        printf("System is NOT in Deadlock (Safe State)\n");
    else
        printf("System is in Deadlock State\n");
}

int main()
{
    int available[M] = {0, 0, 0};

    int allocation[N][M] = {
        {0, 1, 0},   
        {2, 0, 0},   
        {3, 0, 3},   
        {2, 1, 1},   
        {0, 0, 2}    
    };

    int request[N][M] = {
        {0, 0, 0},  
        {2, 0, 2},   
        {0, 0, 0},  
        {1, 0, 0},  
        {0, 0, 2}    
    };

    printf("=== CASE (a): Original System ===\n");
    detectDeadlock(available, allocation, request);

    // P2 requests one more instance of C
    printf("\n=== CASE (b): P2 Requests 1 More Instance of C ===\n");

    request[2][2] += 1;   // Increase request of C by 1

    detectDeadlock(available, allocation, request);

    return 0;
}

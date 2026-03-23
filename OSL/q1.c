#include <stdio.h>

#define MAX 10

struct hole {
    int size;
    int remaining;
};

struct process {
    int size;
    int allocated; // hole index
};

void firstFit(struct hole h[], int nh, struct process p[], int np) {
    int i, j;

    for(i = 0; i < nh; i++)
        h[i].remaining = h[i].size;

    for(i = 0; i < np; i++)
        p[i].allocated = -1;

    for(i = 0; i < np; i++) {
        for(j = 0; j < nh; j++) {
            if(h[j].remaining >= p[i].size) {
                p[i].allocated = j;
                h[j].remaining -= p[i].size;
                break;
            }
        }
    }

    printf("\nFirst Fit Allocation:\n");
    for(i = 0; i < np; i++) {
        if(p[i].allocated != -1)
            printf("Process %d (%dK) -> Hole %d\n", i+1, p[i].size, p[i].allocated+1);
        else
            printf("Process %d (%dK) -> Not Allocated\n", i+1, p[i].size);
    }
}


void bestFit(struct hole h[], int nh, struct process p[], int np) {
    int i, j, best;

    for(i = 0; i < nh; i++)
        h[i].remaining = h[i].size;

    for(i = 0; i < np; i++)
        p[i].allocated = -1;

    for(i = 0; i < np; i++) {
        best = -1;
        for(j = 0; j < nh; j++) {
            if(h[j].remaining >= p[i].size) {
                if(best == -1 || h[j].remaining < h[best].remaining)
                    best = j;
            }
        }

        if(best != -1) {
            p[i].allocated = best;
            h[best].remaining -= p[i].size;
        }
    }

    printf("\nBest Fit Allocation:\n");
    for(i = 0; i < np; i++) {
        if(p[i].allocated != -1)
            printf("Process %d (%dK) -> Hole %d\n", i+1, p[i].size, p[i].allocated+1);
        else
            printf("Process %d (%dK) -> Not Allocated\n", i+1, p[i].size);
    }
}


void worstFit(struct hole h[], int nh, struct process p[], int np) {
    int i, j, worst;

    for(i = 0; i < nh; i++)
        h[i].remaining = h[i].size;

    for(i = 0; i < np; i++)
        p[i].allocated = -1;

    for(i = 0; i < np; i++) {
        worst = -1;
        for(j = 0; j < nh; j++) {
            if(h[j].remaining >= p[i].size) {
                if(worst == -1 || h[j].remaining > h[worst].remaining)
                    worst = j;
            }
        }

        if(worst != -1) {
            p[i].allocated = worst;
            h[worst].remaining -= p[i].size;
        }
    }

    printf("\nWorst Fit Allocation:\n");
    for(i = 0; i < np; i++) {
        if(p[i].allocated != -1)
            printf("Process %d (%dK) -> Hole %d\n", i+1, p[i].size, p[i].allocated+1);
        else
            printf("Process %d (%dK) -> Not Allocated\n", i+1, p[i].size);
    }
}

int main() {
    struct hole h[MAX];
    struct process p[MAX];

    int nh = 5, np = 4;

    int holeSizes[] = {100, 500, 200, 300, 600};

    int processSizes[] = {212, 417, 112, 426};

    int i;

    for(i = 0; i < nh; i++)
        h[i].size = holeSizes[i];

    for(i = 0; i < np; i++)
        p[i].size = processSizes[i];

    firstFit(h, nh, p, np);
    bestFit(h, nh, p, np);
    worstFit(h, nh, p, np);

    return 0;
}

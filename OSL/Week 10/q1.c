#include <stdio.h>
#include <stdlib.h>

int isPresent(int *frames, int frameSize, int page) {
    for (int i = 0; i < frameSize; i++) {
        if (frames[i] == page)
            return 1;
    }
    return 0;
}

// FIFO Algorithm
void fifo(int *pages, int n, int frameSize) {
    int *frames = (int *)malloc(frameSize * sizeof(int));
    int front = 0, faults = 0;

    for (int i = 0; i < frameSize; i++)
        frames[i] = -1;

    for (int i = 0; i < n; i++) {
        if (!isPresent(frames, frameSize, pages[i])) {
            frames[front] = pages[i];
            front = (front + 1) % frameSize;
            faults++;
        }
    }

    printf("FIFO Page Faults: %d\n", faults);
    free(frames);
}

int findOptimal(int *pages, int n, int *frames, int frameSize, int current) {
    int farthest = current, index = -1;

    for (int i = 0; i < frameSize; i++) {
        int j;
        for (j = current + 1; j < n; j++) {
            if (frames[i] == pages[j]) {
                if (j > farthest) {
                    farthest = j;
                    index = i;
                }
                break;
            }
        }
        if (j == n)
            return i; 
    }

    return (index == -1) ? 0 : index;
}

void optimal(int *pages, int n, int frameSize) {
    int *frames = (int *)malloc(frameSize * sizeof(int));
    int faults = 0;

    for (int i = 0; i < frameSize; i++)
        frames[i] = -1;

    for (int i = 0; i < n; i++) {
        if (!isPresent(frames, frameSize, pages[i])) {
            int pos = -1;

            for (int j = 0; j < frameSize; j++) {
                if (frames[j] == -1) {
                    pos = j;
                    break;
                }
            }

            if (pos == -1)
                pos = findOptimal(pages, n, frames, frameSize, i);

            frames[pos] = pages[i];
            faults++;
        }
    }

    printf("Optimal Page Faults: %d\n", faults);
    free(frames);
}

int main() {
    int n, frameSize;

    printf("Enter number of pages: ");
    scanf("%d", &n);

    int *pages = (int *)malloc(n * sizeof(int));

    printf("Enter page reference string:\n");
    for (int i = 0; i < n; i++)
        scanf("%d", &pages[i]);

    printf("Enter number of frames: ");
    scanf("%d", &frameSize);

    fifo(pages, n, frameSize);
    optimal(pages, n, frameSize);

    free(pages);
    return 0;
}

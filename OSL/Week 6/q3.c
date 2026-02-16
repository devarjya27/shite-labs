#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/wait.h>

struct shared_data {
    char alphabet;
    int status; // 0: Empty, 1: Parent Sent, 2: Child Replied
};

int main() {

    key_t key = ftok("shmfile", 65);
    int shmid = shmget(key, sizeof(struct shared_data), 0666 | IPC_CREAT);

    struct shared_data *shm_ptr = (struct shared_data*) shmat(shmid, NULL, 0);
    shm_ptr->status = 0;

    pid_t pid = fork();

    if (pid > 0) {
        char input;
        printf("Parent: Enter an English alphabet: ");
        scanf(" %c", &input);

        shm_ptr->alphabet = input;
        shm_ptr->status = 1; // Signal Child that data is ready

        printf("Parent: Sent '%c' to Child. Waiting for reply...\n", input);

        // Wait for Child to update the status to 2
        while (shm_ptr->status != 2) {
            usleep(100); 
        }

        printf("Parent: Received reply from Child: '%c'\n", shm_ptr->alphabet);

        // Clean up
        wait(NULL);
        shmdt(shm_ptr);
        shmctl(shmid, IPC_RMID, NULL);

    } else if (pid == 0) {
        
        // Wait for Parent to provide data (status 1)
        while (shm_ptr->status != 1) {
            usleep(100);
        }

        printf("Child: Received '%c'. Calculating next alphabet...\n", shm_ptr->alphabet);
        
        shm_ptr->alphabet = shm_ptr->alphabet + 1;
        shm_ptr->status = 2; // Signal Parent that reply is ready

        shmdt(shm_ptr);
        exit(0);
    }

    return 0;
}

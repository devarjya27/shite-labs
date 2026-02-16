#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <sys/wait.h>

#define MAX_WORDS 4
#define WORD_LEN 20

// Define a structure for shared memory
struct shared_buffer {
    char words[MAX_WORDS][WORD_LEN];
    int ready_flag; // 0: Empty, 1: Data Written
};

int main() {
    // Generate a unique key
    key_t key = ftok("shm_words", 65);

    // Create shared memory segment (size of our struct)
    int shmid = shmget(key, sizeof(struct shared_buffer), 0666 | IPC_CREAT);
    if (shmid == -1) {
        perror("shmget");
        exit(1);
    }

    // Attach to the shared memory
    struct shared_buffer *shm_ptr = (struct shared_buffer*) shmat(shmid, NULL, 0);
    shm_ptr->ready_flag = 0;

    pid_t pid = fork();

    if (pid > 0) { 
        char *input_words[MAX_WORDS] = {"Apple", "Banana", "Cherry", "Date"};
        
        printf("Producer: Writing words to shared memory...\n");
        for (int i = 0; i < MAX_WORDS; i++) {
            strcpy(shm_ptr->words[i], input_words[i]);
            printf("Producer: Wrote '%s'\n", input_words[i]);
        }

        shm_ptr->ready_flag = 1; // Signal the consumer

        wait(NULL); // Wait for child to finish reading

        // Detach and Delete
        shmdt(shm_ptr);
        shmctl(shmid, IPC_RMID, NULL);
        printf("Producer: Memory detached and deleted.\n");

    } else if (pid == 0) {
        
        // Wait until the producer sets the flag
        while (shm_ptr->ready_flag == 0) {
            usleep(1000); 
        }

        printf("\nConsumer: Reading words from shared memory...\n");
        for (int i = 0; i < MAX_WORDS; i++) {
            printf("Consumer: Read '%s'\n", shm_ptr->words[i]);
        }

        shmdt(shm_ptr);
        exit(0);
    }

    return 0;
}

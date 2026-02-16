#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>

#define FIFO_NAME "my_fifo_queue"

int main() {
    int fd;
    int data_to_send[4] = {10, 25, 50, 75};
    int data_received[4];
    // 0666 gives read/write permissions to all users
    if (mkfifo(FIFO_NAME, 0666) == -1) {
        perror("mkfifo");
    }

    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        return 1;
    }

    if (pid > 0) { 
        printf("Producer: Writing 4 integers to FIFO...\n");
        
        fd = open(FIFO_NAME, O_WRONLY);
        if (fd == -1) return 1;

        write(fd, data_to_send, sizeof(data_to_send));
        close(fd);
        
        wait(NULL); 
        unlink(FIFO_NAME); 
        printf("Producer: FIFO cleaned up and exiting.\n");

    } else {
        sleep(1); 

        fd = open(FIFO_NAME, O_RDONLY);
        if (fd == -1) return 1;

        read(fd, data_received, sizeof(data_received));
        
        printf("Consumer: Received integers: ");
        for(int i = 0; i < 4; i++) {
            printf("%d ", data_received[i]);
        }
        printf("\n");

        close(fd);
        exit(0);
    }

    return 0;
}

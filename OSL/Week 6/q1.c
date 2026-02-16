#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>

#define FIFO_FILE "/tmp/my_test_fifo"

void check_palindrome(int n) {
    int reversed = 0, remainder, original = n;
    while (n > 0) {
        remainder = n % 10;
        reversed = reversed * 10 + remainder;
        n /= 10;
    }
    if (original == reversed)
        printf("Child 2 (Receiver): %d is a Palindrome.\n", original);
    else
        printf("Child 2 (Receiver): %d is NOT a Palindrome.\n", original);
}

int main() {
    mkfifo(FIFO_FILE, 0666);

    pid_t p1 = fork();

    if (p1 == 0) {
        int fd, num;
        printf("Child 1 (Sender): Enter a number: ");
        scanf("%d", &num);

        fd = open(FIFO_FILE, O_WRONLY);
        write(fd, &num, sizeof(num));
        close(fd);
        exit(0);
    } else {
        pid_t p2 = fork();

        if (p2 == 0) {
            int fd, received_num;
            
            fd = open(FIFO_FILE, O_RDONLY);
            read(fd, &received_num, sizeof(received_num));
            printf("Child 2 (Receiver): Received %d from FIFO.\n", received_num);
            
            check_palindrome(received_num);
            close(fd);
            exit(0);
        }
    }

    wait(NULL);
    wait(NULL);

    unlink(FIFO_FILE);
    printf("Parent: Children finished. FIFO removed.\n");

    return 0;
}

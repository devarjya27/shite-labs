#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t p = fork();

    if (p == 0) {
        printf("child process\n");
        printf("child PID: %d | child's parent PID: %d\n\n", getpid(), getppid());
    } 
    else {
        wait(NULL);

        printf("parent process\n");
        printf("parent PID: %d | parent's parent PID: %d\n", getpid(), getppid());
    }

    return 0;
}

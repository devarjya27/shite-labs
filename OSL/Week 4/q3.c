#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t p = fork();

    if (p == 0) {
        // Child dies immediately
        printf("Child (PID: %d) exiting...\n", getpid());
        exit(0);
    } 
    else {
        // Parent sleeps, keeping the dead child a zombie
        printf("Parent (PID: %d) sleeping for 20s. Check 'ps' now.\n", getpid());
        sleep(20);
        
        printf("Parent exiting. Child will be adopted by init.\n");
        exit(0);
    }
    return 0;
}

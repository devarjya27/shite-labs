#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        printf("Fork failed!\n");
        return 1;
    } 
    else if (pid == 0) {
        printf("loader child. will load q1 binary");

        // execl(path, command_name, arguments..., NULL)
        execl("./q1", "./q1", NULL);

        // This line only runs if execl fails
        printf("could not load the program.\n");
    } 
    else {
        wait(NULL);
        printf("loader parent. The child program has finished.\n");
    }

    return 0;
}

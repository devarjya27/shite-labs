#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>

sem_t rw_mutex;    // Controls access to the shared resource
sem_t mutex;       // Controls access to the read_count variable
int read_count = 0;
int shared_data = 0; 

void* reader(void* arg) {
    int f = *((int*)arg);
    
    // Entry Section
    sem_wait(&mutex);
    read_count++;
    if (read_count == 1) {
        sem_wait(&rw_mutex); // First reader locks the resource from writers
    }
    sem_post(&mutex);

    // Critical Section (Reading)
    printf("Reader %d: read shared_data as %d\n", f, shared_data);
    sleep(1); // Simulate reading time

    // Exit Section
    sem_wait(&mutex);
    read_count--;
    if (read_count == 0) {
        sem_post(&rw_mutex); // Last reader unlocks the resource for writers
    }
    sem_post(&mutex);
    
    return NULL;
}

void* writer(void* arg) {
    int f = *((int*)arg);

    // Entry Section
    sem_wait(&rw_mutex); // Writer requests exclusive access

    // Critical Section (Writing)
    shared_data += 10;
    printf("Writer %d: updated shared_data to %d\n", f, shared_data);
    sleep(1); // Simulate writing time

    // Exit Section
    sem_post(&rw_mutex); // Writer releases access
    
    return NULL;
}

int main() {
    pthread_t r[5], w[2];
    int ids[5] = {1, 2, 3, 4, 5};

    sem_init(&mutex, 0, 1);
    sem_init(&rw_mutex, 0, 1);

    // Creating a mix of readers and writers
    pthread_create(&w[0], NULL, writer, &ids[0]);
    pthread_create(&r[0], NULL, reader, &ids[0]);
    pthread_create(&r[1], NULL, reader, &ids[1]);
    pthread_create(&w[1], NULL, writer, &ids[1]);
    pthread_create(&r[2], NULL, reader, &ids[2]);

    for(int i = 0; i < 3; i++) pthread_join(r[i], NULL);
    for(int i = 0; i < 2; i++) pthread_join(w[i], NULL);

    sem_destroy(&mutex);
    sem_destroy(&rw_mutex);

    return 0;
}

// 1. Design and implement a Java application to simulate a Hotel Room Service
// Management System where multiple service requests are handled concurrently using multithreading.
// i. In a hotel, different room service tasks such as room cleaning, food delivery, and maintenance may occur at the same time. To efficiently manage these tasks, the application should create separate threads for each service request so that they can execute concurrently rather than sequentially.
// ii. Create individual threads for different service operations using Java thread creation techniques (Thread class or Runnable interface). Each thread should simulate a service task by displaying status messages and pausing execution using the sleep() method to represent processing time.
// iii. The main program should start multiple threads simultaneously and demonstrate concurrent execution of hotel service tasks

class RoomCleaning extends Thread {
    public void run() {
        try {
            System.out.println("Room Cleaning started...");
            Thread.sleep(2000);
            System.out.println("Room Cleaning completed!");
        } catch (InterruptedException e) {
            System.out.println("Thread Interrupted");
        }
    }
}

class FoodDelivery extends Thread {
    public void run() {
        try {
            System.out.println("Food Delivery started...");
            Thread.sleep(1500);
            System.out.println("Food Delivery completed!");
        } catch (InterruptedException e) {
            System.out.println("Thread Interrupted");
        }
    }
}

class Maintenance extends Thread {
    public void run() {
        try {
            System.out.println("Maintenance started...");
            Thread.sleep(2500);
            System.out.println("Maintenance completed!");
        } catch (InterruptedException e) {
            System.out.println("Thread Interrupted");
        }
    }
}

public class ex1 {
    public static void main(String[] args) {

        RoomCleaning cleaningThread = new RoomCleaning();
        FoodDelivery foodThread = new FoodDelivery();
        Maintenance maintenanceThread = new Maintenance();

        cleaningThread.start();
        foodThread.start();
        maintenanceThread.start();

        try {
            cleaningThread.join();
            foodThread.join();
            maintenanceThread.join();
        } catch (InterruptedException e) {
            System.out.println("Thread Interrupted");
        }

        System.out.println("All service requests completed!");
    }
}

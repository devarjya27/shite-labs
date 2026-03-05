class OrderValidation extends Thread{
    
    public void run(){
            try {
                System.out.println("Order validation started...");
            Thread.sleep(2500);
            System.out.println("Order validation completed!");
            } catch (InterruptedException e) {
                System.out.println("Thread interrupted!");
            }
        }
    }

class PaymentProcessing extends Thread{
    
    public void run(){
        try {
            System.out.println("Payment Processing started...");
        Thread.sleep(1500);
        System.out.println("Payment Processing completed!");
        } catch (InterruptedException e) {
            System.out.println("Thread interrupted!");
        }
    }
}

class OrderShipment extends Thread{

    public void run(){
        try {
            System.out.println("Order shipment started...");
        Thread.sleep(2200);
        System.out.println("Order shipment completed!");
        } catch (InterruptedException e) {
            System.out.println("Thread interrupted!");
        }
    }
}

public class ex2 {
    public static void main(String[] args) {
        OrderValidation v1 = new OrderValidation();
        PaymentProcessing p1 = new PaymentProcessing();
        OrderShipment o1 = new OrderShipment();

        v1.start();
        o1.start();
        p1.start();
    }
}

/* 4. Create an abstract class named Room that represents a generic hotel room.
The abstract class should contain common data members such as room number and
base price, and include an abstract method calculateTariff().
Create derived classes StandardRoom and LuxuryRoom.
Create an interface Amenities with methods provideWifi() and provideBreakfast().
Demonstrate abstraction and interface-based design using a base class reference. */

abstract class Room {
    int roomNumber;
    double basePrice;

    Room(int roomNumber, double basePrice) {
        this.roomNumber = roomNumber;
        this.basePrice = basePrice;
    }

    abstract void calculateTariff();

    void displayRoomDetails() {
        System.out.println("Room Number: " + roomNumber);
        System.out.println("Base Price: " + basePrice);
    }
}

interface Amenities {
    void provideWifi();
    void provideBreakfast();
}

class StandardRoom extends Room implements Amenities {
    boolean wifi;
    boolean breakfast;

    StandardRoom(int roomNumber, double basePrice, boolean wifi, boolean breakfast) {
        super(roomNumber, basePrice);
        this.wifi = wifi;
        this.breakfast = breakfast;
    }

    void calculateTariff() {
        double totalTariff = basePrice;
        if (wifi == true)
            totalTariff += 200;
        if (breakfast == true)
            totalTariff += 150;

        System.out.println("Standard Room Tariff: " + totalTariff);
    }

    public void provideWifi() {
        if (wifi == true)
            System.out.println("WiFi Available");
        else
            System.out.println("WiFi Not Available");
    }

    public void provideBreakfast() {
        if (breakfast == true)
            System.out.println("Breakfast Available");
        else
            System.out.println("Breakfast Not Available");
    }
}

class LuxuryRoom extends Room implements Amenities {
    boolean wifi;
    boolean breakfast;

    LuxuryRoom(int roomNumber, double basePrice, boolean wifi, boolean breakfast) {
        super(roomNumber, basePrice);
        this.wifi = wifi;
        this.breakfast = breakfast;
    }

    void calculateTariff() {
        double totalTariff = basePrice;
        if (wifi == true)
            totalTariff += 300;
        if (breakfast == true)
            totalTariff += 250;

        System.out.println("Luxury Room Tariff: " + totalTariff);
    }

    public void provideWifi() {
        System.out.println("High-Speed WiFi Available");
    }

    public void provideBreakfast() {
        System.out.println("Premium Breakfast Available");
    }
}

public class ex4 {
    public static void main(String[] args) {

        Room room1 = new StandardRoom(101, 1000, true, false);
        Room room2 = new LuxuryRoom(102, 2000, true, true);

        room1.displayRoomDetails();
        room1.calculateTariff();
        ((Amenities) room1).provideWifi();
        ((Amenities) room1).provideBreakfast();

        System.out.println();

        room2.displayRoomDetails();
        room2.calculateTariff();
        ((Amenities) room2).provideWifi();
        ((Amenities) room2).provideBreakfast();
    }
}

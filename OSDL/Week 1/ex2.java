/*  2. Create a base class named Room to represent general room details in a hotel. The
class should contain data members such as room number, room type, and base
price. Implement multiple constructors (constructor overloading) in the Room 
class to initialize room objects in different ways, such as:
i. Initializing only the room number and type
ii. Initializing room number, type, and base price
iii. Create a derived class named DeluxeRoom that inherits from the Room class
using single inheritance. The derived class should include additional data
members such as free Wi-Fi availability and complimentary breakfast.
Implement appropriate constructors in the derived class that invoke the base
class constructors using the super keyword.
iv. Create a main class to instantiate objects of both Room and DeluxeRoom using
different constructors and display the room details. This application should
clearly illustrate constructor overloading and inheritance. */
class Room {
    int roomNumber;
    String roomType;
    float roomBasePrice;

    Room(int roomNumber, String roomType)
    {
        this.roomNumber = roomNumber;
        this.roomType =roomType;
    }

    Room(int roomNumber, String roomType, float roomBasePrice)
    {
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.roomBasePrice = roomBasePrice;
    }

    void displayRoomDetails()
    {
        System.out.println("Room Number: " + roomNumber);
        System.out.println("Room Type: " + roomType);
        System.out.println("Room Base Price: " + roomBasePrice);
    }
}

class DeluxeRoom extends Room {
    boolean freeWifi;
    boolean Breakfast;

    DeluxeRoom(int roomNumber, String roomType, boolean freeWifi, boolean Breakfast) {
        super(roomNumber, roomType);
        this.freeWifi = freeWifi;
        this.Breakfast = Breakfast;
    }

    DeluxeRoom(int roomNumber, String roomType, float roomBasePrice, boolean freeWifi, boolean Breakfast) {
        super(roomNumber, roomType, roomBasePrice);
        this.freeWifi = freeWifi;
        this.Breakfast = Breakfast;
    }

    void displayDeluxeDetails() {
        super.displayRoomDetails();
        if(freeWifi == true)
            System.out.println("Free Wifi Available");
        else
            System.out.println("Free Wifi Not Available");
        if(Breakfast == true)
            System.out.println("Complimentary Breakfast Available");
        else
            System.out.println("Complimentary Breakfast Not Available");
        }

}

public class ex2 {
    public static void main(String[] args)
    {
        Room room1 = new Room(101, "Normal");
        Room room2 = new Room(102, "Normal", 2000);
        DeluxeRoom deluxeroom1 = new DeluxeRoom(103, "Deluxe", true, false);
        DeluxeRoom deluxeroom2 = new DeluxeRoom(104, "Deluxe", 4000, true, true);

        room1.displayRoomDetails();
        room2.displayRoomDetails();
        deluxeroom1.displayDeluxeDetails();
        deluxeroom2.displayDeluxeDetails();
    }
}
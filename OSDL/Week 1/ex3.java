/* 3. Design and implement a Java application to simulate a Hotel Room Booking System
that demonstrates the object-oriented concepts of inheritance and runtime
polymorphism.
i. Create a base class named Room that represents a general hotel room. The class should
contain data members such as room number and base tariff, and a method
calculateTariff() to compute the room cost.
ii. Create derived classes such as StandardRoom and LuxuryRoom that inherit from the
Room class. Each derived class should override the calculateTariff() method to
compute the tariff based on room-specific features such as air conditioning, additional
amenities, or premium services.
iii. In the main class, create a base class reference of type Room and assign it to objects of
different derived classes (StandardRoom, LuxuryRoom). Invoke the
calculateTariff() method using the base class reference to demonstrate runtime
polymorphism, where the method call is resolved at runtime based on the actual
object type */

class HotelRoom {
    int roomNumber;
    double baseTariff;

    HotelRoom(int roomNumber, double baseTariff)
    {
        this.roomNumber = roomNumber;
        this.baseTariff = baseTariff;
    }

    void calculateTariff()
    {
        double totalTariff = baseTariff;
        System.out.println("Room Number: "+ roomNumber);
        System.out.println("Total Tariff: $"+ totalTariff);
    }
}

class StandardRoom extends HotelRoom {
    boolean airConditioning;
    boolean amenities;
    double totalTariff;

    StandardRoom(int roomNumber, double baseTariff, boolean airConditioning, boolean amenities)
    {
        super(roomNumber, baseTariff);
        this.airConditioning = airConditioning;
        this.amenities = amenities;
    }
    void calculateTariff()
    {
        int airConditioningTariff, amenitiesTariff;
        if(airConditioning == true)
            airConditioningTariff = 1;
        else
            airConditioningTariff = 0;

        if(amenities == true)
            amenitiesTariff = 1;
        else
            amenitiesTariff = 0;
        totalTariff = baseTariff + airConditioningTariff*200 + amenitiesTariff*100;
        System.out.println("Room Number: "+ roomNumber);
        System.out.println("Total Tariff: $"+ totalTariff);
    }

}

class LuxuryRoom extends HotelRoom {
    boolean airConditioning;
    boolean amenities;
    boolean premiumServices;
    double totalTariff;

    LuxuryRoom(int roomNumber, double baseTariff, boolean airConditioning, boolean amenities, boolean premiumServices)
    {
        super(roomNumber, baseTariff);
        this.airConditioning = airConditioning;
        this.amenities = amenities;
        this.premiumServices = premiumServices;
    }
    void calculateTariff()
    {
        int airConditioningTariff, amenitiesTariff, premiumServicesTariff;
        if(airConditioning == true)
            airConditioningTariff = 1;
        else
            airConditioningTariff = 0;

        if(amenities == true)
            amenitiesTariff = 1;
        else
            amenitiesTariff = 0;

        if(premiumServices == true)
            premiumServicesTariff = 1;
        else
            premiumServicesTariff = 0;

        totalTariff = baseTariff + airConditioningTariff*200 + amenitiesTariff*100 + premiumServicesTariff*500;
        System.out.println("Room Number: "+ roomNumber);
        System.out.println("Total Tariff: $"+ totalTariff);
    }

}


public class ex3 {
    public static void main(String[] args)
    {
    StandardRoom room1 = new StandardRoom(101, 500, true, true);
    LuxuryRoom room2 = new LuxuryRoom(102, 500, true,true,true);
    HotelRoom room3 = new HotelRoom(103, 500);

    room1.calculateTariff();
    room2.calculateTariff();
    room3.calculateTariff();
}
}
    


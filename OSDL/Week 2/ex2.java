enum RoomType {
    STANDARD(1500.0), 
    DELUXE(2500.0),
    SUITE(4000.0);

    private double baseTariff;

    RoomType(double baseTariff) {
        this.baseTariff = baseTariff;
    }

    public double getBaseTariff() {
        return baseTariff;
    }

    public double calculateTotalCost(int days) {
        return baseTariff * days;
    }
}

// Main class
public class ex2 {
    public static void main(String[] args) {
        RoomType selectedRoom = RoomType.DELUXE; 
        int daysStayed = 3;

        double baseTariff = selectedRoom.getBaseTariff();
        double totalCost = selectedRoom.calculateTotalCost(daysStayed);

        System.out.println("Selected Room Type: " + selectedRoom);
        System.out.println("Base Tariff (per day): " + baseTariff);
        System.out.println("Number of Days Stayed: " + daysStayed);
        System.out.println("Total Room Tariff: " + totalCost);
    }
}
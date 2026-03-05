public class ex1 {
    public static void main(String[] args) {

        double roomTariffPrimitive = 1500.0;
        int daysPrimitive = 3;               
        double serviceChargePrimitive = 500.0; 

        Double roomTariff = roomTariffPrimitive;
        Integer daysStayed = daysPrimitive;
        Double serviceCharge = serviceChargePrimitive;

        double totalRoomCost = roomTariff * daysStayed; 
        double totalBill = totalRoomCost + serviceCharge;

        System.out.println("Hotel Billing System");
        System.out.println("---------------------");
        System.out.println("Room Tariff (per day): " + roomTariff);
        System.out.println("Number of Days Stayed: " + daysStayed);
        System.out.println("Service Charges: " + serviceCharge);
        System.out.println("Total Bill Amount: " + totalBill);
    }
}


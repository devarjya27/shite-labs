
import java.io.*;
import java.util.*;

// i. Room class implementing Serializable
class Room implements Serializable {

    private static final long serialVersionUID = 1L;
    int roomNumber;
    String roomType;
    double price;
    boolean isBooked;
    String guestName;

    public Room(int roomNumber, String roomType, double price, boolean isBooked, String guestName) {
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.price = price;
        this.isBooked = isBooked;
        this.guestName = guestName;
    }

    @Override
    public String toString() {
        return "Room: " + roomNumber + " | Type: " + roomType + " | Price: " + price
                + " | Status: " + (isBooked ? "Booked by " + guestName : "Vacant");
    }
}

public class HotelManagementSystem {

    private static final String FILE_NAME = "bookings.ser";

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("\n1. Add 2. Display All 3. Search 4. Update 5. Exit");
            int choice = sc.nextInt();

            if (choice == 1) {
                addRoom(sc);
            } else if (choice == 2) {
                displayAll();
            } else if (choice == 3) {
                searchRoom(sc);
            } else if (choice == 4) {
                updateStatus(sc);
            } else {
                break;
            }
        }
    }

    // iii. Serialize and store
    private static void saveToFile(List<Room> rooms) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_NAME))) {
            oos.writeObject(rooms);
        } catch (IOException e) {
            System.out.println("Error saving: " + e.getMessage());
        }
    }

    // iv. Deserialize and retrieve
    @SuppressWarnings("unchecked")
    private static List<Room> readFromFile() {
        File file = new File(FILE_NAME);
        if (!file.exists()) {
            return new ArrayList<>();
        }
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_NAME))) {
            return (List<Room>) ois.readObject();
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    private static void addRoom(Scanner sc) {
        List<Room> rooms = readFromFile();
        System.out.print("Room No, Type, Price: ");
        rooms.add(new Room(sc.nextInt(), sc.next(), sc.nextDouble(), false, "None"));
        saveToFile(rooms);
    }

    private static void displayAll() {
        readFromFile().forEach(System.out::println);
    }

    private static void searchRoom(Scanner sc) {
        System.out.print("Enter Room No: ");
        int num = sc.nextInt();
        readFromFile().stream().filter(r -> r.roomNumber == num).findFirst().ifPresentOrElse(System.out::println, () -> System.out.println("Not Found"));
    }

    // v. Update by Deserializing -> Modifying -> Re-serializing
    private static void updateStatus(Scanner sc) {
        List<Room> rooms = readFromFile();
        System.out.print("Enter Room No to Update: ");
        int num = sc.nextInt();

        for (Room r : rooms) {
            if (r.roomNumber == num) {
                System.out.print("Book? (true/false): ");
                r.isBooked = sc.nextBoolean();
                if (r.isBooked) {
                    System.out.print("Guest Name: ");
                    r.guestName = sc.next();
                } else {
                    r.guestName = "None";
                }
                saveToFile(rooms);
                return;
            }
        }
        System.out.println("Room not found.");
    }
}

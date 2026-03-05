
import java.io.*;
import java.util.Scanner;

public class HotelManagement {

    private static final String FILE_NAME = "hotel_rooms.dat";
    private static final int RECORD_SIZE = 53; // 4 + 40 + 8 + 1
    private static final int STRING_SIZE = 20;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("\n1. Add Room\n2. View Room\n3. Update Status\n4. Exit");
            int choice = sc.nextInt();
            try {
                switch (choice) {
                    case 1 ->
                        addRoom(sc);
                    case 2 ->
                        viewRoom(sc);
                    case 3 ->
                        updateStatus(sc);
                    case 4 ->
                        System.exit(0);
                }
            } catch (IOException e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }

    private static void addRoom(Scanner sc) throws IOException {
        try (RandomAccessFile raf = new RandomAccessFile(FILE_NAME, "rw")) {
            raf.seek(raf.length()); // Go to end
            System.out.print("Room Number: ");
            raf.writeInt(sc.nextInt());

            System.out.print("Room Type (max 20 chars): ");
            writeFixedString(raf, sc.next());

            System.out.print("Price: ");
            raf.writeDouble(sc.nextDouble());

            raf.writeBoolean(false); // Default: Vacant
        }
    }

    private static void viewRoom(Scanner sc) throws IOException {
        System.out.print("Enter Room Index (0, 1, 2...): ");
        int index = sc.nextInt();

        try (RandomAccessFile raf = new RandomAccessFile(FILE_NAME, "r")) {
            if (index * RECORD_SIZE >= raf.length()) {
                System.out.println("Record not found.");
                return;
            }
            raf.seek((long) index * RECORD_SIZE);

            System.out.println("Room No: " + raf.readInt());
            System.out.println("Type: " + readFixedString(raf).trim());
            System.out.println("Price: " + raf.readDouble());
            System.out.println("Booked: " + raf.readBoolean());
        }
    }

    private static void updateStatus(Scanner sc) throws IOException {
        System.out.print("Enter Room Index to toggle status: ");
        int index = sc.nextInt();

        try (RandomAccessFile raf = new RandomAccessFile(FILE_NAME, "rw")) {
            long pos = (long) index * RECORD_SIZE + 52; // Jump to boolean (4+40+8)
            if (pos >= raf.length()) {
                System.out.println("Record not found.");
                return;
            }
            raf.seek(pos);
            boolean currentStatus = raf.readBoolean();
            raf.seek(pos); // Move back to overwrite
            raf.writeBoolean(!currentStatus);
            System.out.println("Status updated to: " + (!currentStatus ? "Booked" : "Vacant"));
        }
    }

    private static void writeFixedString(RandomAccessFile raf, String str) throws IOException {
        for (int i = 0; i < STRING_SIZE; i++) {
            char c = (i < str.length()) ? str.charAt(i) : ' ';
            raf.writeChar(c);
        }
    }

    private static String readFixedString(RandomAccessFile raf) throws IOException {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < STRING_SIZE; i++) {
            sb.append(raf.readChar());
        }
        return sb.toString();
    }
}


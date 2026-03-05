enum RoomType {
    suite,deluxe,standard
}

class Hotel{
    private int roomsOccupied, totalRooms;
    private Boolean occupied[], cleaned[];
    RoomType type[];

    Hotel(int suiteCount,int deluxeCount, int standardCount) {
        totalRooms = suiteCount + deluxeCount + standardCount;
        type = new RoomType[totalRooms];
        occupied = new Boolean[totalRooms];
        cleaned = new Boolean[totalRooms];

        for(int i = 0; i < suiteCount; i++)type[i] = RoomType.suite;
        for(int i = suiteCount; i < suiteCount+deluxeCount; i++)type[i] = RoomType.deluxe;
        for(int i = suiteCount+deluxeCount;i < totalRooms; i++)type[i] = RoomType.standard;
        for(int i = 0; i < totalRooms; i++)cleaned[i] = true;
        for(int i = 0; i < totalRooms; i++)occupied[i] = false;
    }

    synchronized int bookRoom(String customer, RoomType pref){
        while (true) { 
            for (int i = 0; i < totalRooms; i++){
                if(type[i] == pref && !occupied[i] && cleaned[i]){
                    occupied[i] = true;
                    System.out.println("Customer "+ customer+" checked in to room "+i+"("+pref+")");
                    return i;
                }
            }
            System.out.println("Customer "+customer+" is waiting for a clean "+pref+" room");
            try {
                wait();
            } catch (InterruptedException e) {
                System.out.println("Customer "+customer+" interrupted!");
            }
            
        }
    }

    synchronized void releaseRoom(String customer, int roomno){
        occupied[roomno] = false;
        cleaned[roomno] = false;
        System.out.println("Customer "+customer+" vacated room "+roomno+". Not cleaned");
        notifyAll();
    }

    synchronized int getDirtyRoom(){
        for(int i = 0; i < totalRooms;i++){
            if(!occupied[i] && !cleaned[i])return i;
        }
        return -1;
    }

    synchronized void cleanRoom(int roomno){
        cleaned[roomno] = true;
        System.out.println("Room "+roomno+" cleaned, ready for guest");
        notifyAll();
    }
}

class Customer extends Thread{
    Hotel hotel;
    RoomType pref;
    String name;

    Customer(String n,Hotel h, RoomType p) {
        name = n;
        hotel = h;
        pref = p;
    }

    @Override
    public void run(){
        int roomno = hotel.bookRoom(name, pref);
        try {
            Thread.sleep(4000);
        } catch (InterruptedException e) {
            System.out.println("Customer "+name+" interrupted");
        }
        
        hotel.releaseRoom(name, roomno);
    }
}

class Janitor extends Thread{                                                                           
    final Hotel hotel;

    public Janitor(Hotel hotel){
        this.hotel = hotel;
        this.setDaemon(true);
    }

    @Override
    public void run(){
        try{
            while (true) { 
                int roomno;
                synchronized (hotel){
                    roomno = hotel.getDirtyRoom();
                    if(roomno == -1){
                        hotel.wait();
                        continue;
                    }
                }
                Thread.sleep(3000);
                hotel.cleanRoom(roomno);
            }
        }
        catch (InterruptedException e) {
        }
    }
}

public class Main {
    public static void main(String[] args) {
        Hotel hotel = new Hotel(2, 3, 3);
        Janitor janitor = new Janitor(hotel);
        janitor.start();

        for(int i = 0; i < 5; i++){
            RoomType pref = i<4?RoomType.suite:(i<10?RoomType.deluxe:RoomType.standard);
            new Customer("Guest-"+i, hotel, pref).start();
        }
    }
}

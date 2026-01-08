/* 1. Create a Book class with private data members including book ID, book title,
author name, price, and availability status. Provide public setter methods to assign
values to these data members and public getter methods to retrieve their values.
Include validation in setter methods to ensure that the price is a positive value. */

import java.util.*;
class Book{
    private int bookID;
    private String title;
    private float price;
    private boolean available;

    public void setBookDetails(int bookID, String title, float price, boolean available)
    {
        this.bookID = bookID;
        this.title = title;
        this.price = price;
        this.available = available;
    }

    public int getBookID(){
        return bookID;
    }

    public String getTitle(){
        return title;
    }

    public float getPrice(){
        return price;
    }

    public boolean getAvailability(){
        return available;
    }
}

public class ex1 {
    public static void main(String[] args)
    {
        Book book = new Book();
        Scanner ob = new Scanner(System.in);

        System.out.println("Enter book details: ");
        int bookID = ob.nextInt();
        ob.nextLine();
        String title = ob.nextLine();
        float price = ob.nextFloat();
        boolean available = ob.nextBoolean();

        book.setBookDetails(bookID, title, price, available);

        System.out.println("Book Details: ");
        System.out.println("Book ID: "+ book.getBookID());
        System.out.println("Book Title: "+ book.getTitle());
        System.out.println("Book Price: $"+ book.getPrice());
        if(book.getAvailability() == true)
        System.out.println("Book Available");
        else
        System.out.println("Book Not Available");


    }
}

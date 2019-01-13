import java.util.Scanner;
/**
* @(#)PerryTWhileifElse.java
* @author Trevon Perry
* @version 1.00 2016/02/10@ 10:11
* 
* 
IC: while if/else - Due 2/22/16

Instructions:  Create a program that allows the user to enter a negative or positive integer as many times as the user wants.  If the user enters a negative integer then print the number and a message that says it's negative; otherwise, print the number and a message that says it's positive; otherwise, print a message that zero is neither negative or positive.  You'll use a sentinel-controlled while loop, so ask the user whether he/she wants to enter an integer before entering the while loop.  You'll have to ask the same question again at the end of the while loop.  Save the program as YourLastNameFirstInitialWhileIfElse.java .

Submissions Requirement:  Save to the classes server.
*/

public class PerryTWhileifElse
{
  public static void main (String[] args)
  {
    Scanner input = new Scanner (System.in);
    int number = 0;
    char sentinel = ' ';
    
    System.out.printf("%nDo you want to enter an integer? Enter \'Y\' or \'N\': ");
    sentinel = input.nextLine().charAt(0);
    
    while(Character.toUpperCase(sentinel) == 'Y')
    {
      System.out.printf("%nPlease enter an integer:  ");
      number = input.nextInt();
      input.nextLine();
      
      if(number > 0)
      {
        System.out.printf("%n%d is a positive number.%n", number);
      }
      else
      {
        if(number <0)
          System.out.printf("%n%d is a negative number.%n", number);
        else
          System.out.printf("%n%d is neither positive or negative.%n", number);
      }
      
      System.out.printf("%nDo you want to enter an integer? Enter \'Y\' or \'N\': ");
      sentinel = input.nextLine().charAt(0);
    }
    System.exit(0);
  }//end main()
  
}//end application
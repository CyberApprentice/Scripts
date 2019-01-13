import java.util.Scanner;
import java.text.DecimalFormat;
/**

@(#)PerryTLVRM2
@author Trevon Perry
@version 1.00 2016/03/11@ 10:45
IC: Value-Receiving & Value-Returning Method  - 3/23/16
Collapse
Instructions:  Code a method called multiplyNumbers() that receives two integers through its parameter list and returns 
the product of those two integers.  In the main()

    Prompt users for two integers.
    Call multiplyNumbers() by sending it the two integers.
    Store the value multiplyNumbers() returns in a variable called product.
    Print as follows:

    integer1 * integer2 = product

    where the actual value for the integers and the product is printed.
    Save the code in a program called YourLast NameFirstInitialVRM2.java.
*/



public class PerryTLVRM2
{
  public static void main (String[] args)
  {
    Scanner input = new Scanner(System.in);
    
    System.out.printf("%nInsert two integers that you would like to find the product of:  ");
    int int1 = input.nextInt();
    int int2 = input.nextInt();
    int product = multiplyNumbers(int1, int2);
    System.out.printf("%n" + int1 + " * " + int2 + " = "+ product + "%n");
    //Prompt for 2 ints
    //send the 2 ints in the method call to multiplyNumbers()
    //the product that is retured by multiplyNumbers() is stored
    //in a variable calld product
    //then print the int and the product as a formula
    
      
  }//end main()
  
  public static int multiplyNumbers(int x, int y)
  {
    return x*y;
  }//end multiplyNumbers(int: x, int y: static int
}//end application
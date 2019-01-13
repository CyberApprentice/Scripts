/**
 * 
 * 
 * * @(#)PerryTForFallThruSwitch
* @author Trevon Perry
* @version 1.00 2016/03/02@ 10:20
* 
IC: for Loop/fall-thru switch - Due 3/2/15
Collapse

Instructions: Code a for statement that increments from 1 through 10, but print only the even numbers using a fall-thru switch. You can catch the odd numbers using the option in the switch that handles everything else. Name your program YourLastNameFirstInitialForFallThruSwitch.java.

--------------------OUTPUT RESULTS--------------------

Not printing odd numbers!

2 is an even number.

Not printing odd numbers!

4 is an even number.

Not printing odd numbers!

6 is an even number.

Not printing odd numbers!

8 is an even number.

Not printing odd numbers!

10 is an even number.
*/ 

public class PerryTForFallThruSwitch
{
  public static void main (String [] args)
  {
    for(int x = 1; x<= 10; x++)
    {
      switch (x)
      {
        case 2:
        case 4:
        case 6:
        case 8:
        case 10: System.out.printf("%n%d is an even number.%n", x);
        break;
        default: System.out.printf("%nNot printing odd numbers!");
        
      }
    }
    
  }
}

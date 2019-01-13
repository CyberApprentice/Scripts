import java.util.Scanner;
import java.text.DecimalFormat;

/**

@(#)PerryTVoidRepetionSwitch
@author Trevon Perry
@version 1.00 2016/03/9@ 10:45
IC: void Method, Repetition & Switch - 3/23/16
Collapse

Instructions:  Code a program that has a void method called calcSales. The only code in the main() will be a call to this method and the exit statement.  In calcSales(), print the sum for three (3) months of projected sales figures.  The user will be prompted for sales from each month beginning with January.  Use a switch statement to determine the name of the month.  Code the program using a do-while loop. Use printf() with specifiers.  Name the program YourLastNameFirstInitialVoidRepetitionSwitch.java.

Input Prompt:  The Xs represent the name of the month (January through March).

Enter projected sales for XXXXXXXXX:

where the sales figure is then stored in a salesFigure variable.

Output Specification:

PROJECTED SALES FROM JANUARY - MARCH 2016:  $ZZZ,ZZZ,ZZ9.99

where the value for $ZZZ,ZZZ,ZZ9.99 is stored in the totalSales variable. The $ZZZ,ZZZ,ZZ9.99 also specifies how total sales should look upon output.

-----SAMPLE OUTPUT-----

Enter projected sales for JANUARY:  7825.88

Enter projected sales for FEBRUARY:  10875.66

Enter projected sales for MARCH:  12825.55


PROJECTED SALES FROM JANUARY - MARCH 2016:  $31,527.09
*/

public class PerryTVoidRepetionSwitch
{
  public static void main (String[]args)
  {
    calcSales();
    
    System.exit(0);
  }//end main()
  
  public static void calcSales()
  {
    double sales = 0.0;
    double totalSales = 0.0;
    int month = 1;
    DecimalFormat decimal = new DecimalFormat("$00,000.00");
    Scanner input = new Scanner(System.in);
    
    do
    {
      switch(month)
      {
        case 1:
          System.out.printf("%nEnter projected sales for JANUARY:  ");
          sales = input.nextDouble();
          totalSales += sales;
          month++;
          break;
        case 2:
          System.out.printf("%nEnter projected sales for FEBRUARY:  ");
          sales = input.nextDouble();
          totalSales += sales;
          month++;
          break;
        case 3:
          System.out.printf("%nEnter projected sales for MARCH:  ");
          sales = input.nextDouble();
          totalSales += sales;
          month++;
          break;
      }//end switch on month
    }while(month<=3);
    System.out.printf("%nPROJECTED SALES FROM JANUARY - MARCH 2016:  "+decimal.format(totalSales)+"%n");
  }//end calcSales(): static void
}//end app
/**
 * @(#)PerryTArraysV2.java
 * @author Trevon Perry
 * @version 1.00 2016/04/25 10:45am
 * 
 * Program Purpose: To learn how to create a class, instantiate an object of the 
 * class in another class, and use that object to call methods.  
 * */

import java.util.Scanner;
import java.text.DecimalFormat;

public class PerryTArraysV2
{  
  private static Scanner input = new Scanner(System.in);
  private static DecimalFormat decimal = new DecimalFormat("0.00");
  
  public static void main(String[]args)
  {
    double[][] football = setAvgScores();
    
   for(int x = 0; x<football.length; x++)
    {
      for(int z = 0; z<football[x].length; z++)
      {     
     
       System.out.printf("%nAverage Score for Football Team "+(x + 1)+" - Year "+(z+1)+":  "+
                         decimal.format(football[x][z]));        
       
      }
    }
    System.exit(0);
  }
  
  public static double[][] setAvgScores()
  {
    double[][] football = new double[2][2];
    for(int x = 0; x<football.length; x++)
    {
      for(int z = 0; z<football[x].length; z++)
      {
        System.out.printf("Enter the average score for year "+(z+1)+" of football team "+(x+1)+":  ");
        football[x][z] = input.nextDouble();
        input.nextLine();
      } 
       
    }
    return football;
  }
}
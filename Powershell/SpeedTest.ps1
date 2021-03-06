﻿<#
.Synopsis
   Monitor download and upload speeds
.DESCRIPTION
   The goal is to monitor download and upload speeds throughout the day to understand what times and circumstances affect speeds. The main focus is on download speed. Measurement is in Megabits. Data is logged to a CSV file. Everything is statically set. The program used in conjunction is the speedtest CLI by Ookla to gather data. Unforunthely, the output is not neat due to the lack of parameters.
.EXAMPLE
   .\SpeedTest.ps1
#>
function Verb-Noun
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [int]$Param2
    )

    Begin
    {
        # The Begin block is an optional, preprocessing of the function that will only run once per call of the function. 
        # Use this block to setup the function by initializing objects such as variables, database connections, or arrays that will be used throughout the function.  
        # Any variables that are created in the Begin block will be accessible elsewhere in the function. 
    }
    Process
    {
        # The Process block executes on every object passed through the pipeline
    }
    End
    {
        # The End block is used after all objects have been sent through the pipeline.
    }
}
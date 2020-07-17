<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
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
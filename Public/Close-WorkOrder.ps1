function Close-WorkOrder {
    <#
    .SYNOPSIS
        This function closes a Work Order in Track-it!
    .DESCRIPTION
        This function closes a Work Order in Track-it!, using the Web API.
    .OUTPUTS
        Creats a variable $Result that is available for use in other cmdlets.
    .EXAMPLE
        > Close-WorkOrder
    #>

    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="Medium" 
    )]

    param (
        [Parameter(Mandatory=$True)]
        [String]$WorkOrder
    )

    begin {
        #Creating new Array for result
        $Result = New-Object System.Collections.ArrayList
    }

    process {
        Try {
            # Querying Track-it! Web API
            $Query = Invoke-RestMethod -Method Post -Uri ($RootURI + '/workorder/Close/' + $WorkOrder) -Headers $AuthHeader -ContentType $contentType -ErrorAction Stop
            Write-Verbose "Work Order Closed!"
            # Building new Object of results from the Post
            $Temp = New-Object System.Object
            $Temp | Add-Member -MemberType NoteProperty -Name "Success" -Value $Query.success
            $Temp | Add-Member -MemberType NoteProperty -Name "Status" -Value $Query.data.data.StatusName
            $Temp | Add-Member -MemberType NoteProperty -Name "Message" -Value $Query.data.message
            $Result.Add($Temp) | Out-Null
        }
        Catch {  
            $response = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($response)
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd();
            Write-Host -ForegroundColor Red $_ "---->" $responseBody
            Break
        }
        $Result
    }

    end {
        # Nulling out unused variables
        $WorkOrder = $Null
        $Query = $Null
        $Temp = $Null
        $response = $Null
        $reader = $Null
        $responseBody = $Null
    }
}

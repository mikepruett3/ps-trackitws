function Import-Categories {
    <#
    .SYNOPSIS
        This function creates a list of Categories, Types and Subtypes for Track-it!
    .DESCRIPTION
        This function creates a new Object of Categories, Types and Subtypes for Track-it!
    .OUTPUTS
        Creats a variable $Result that is available for use in other cmdlets.
    .EXAMPLE
        > Load-Categories
    #>

    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="Medium"
    )]

    param (
        [parameter(Mandatory=$True,HelpMessage="Enter path to Comma-Delimited file of Categories to import.")]
        [ValidateScript({Test-Path $_ -PathType 'Leaf'})]
        [String]$Path#,
        #[String]$Category
    )

    begin {

        # Creating new Array for result
        $Result = New-Object System.Collections.ArrayList
    }

    process {

        # Try {
        #     # Querying Track-it! Web API
        #     $Query = Invoke-RestMethod -Method Get -Uri ($RootURI + '/workorder/Get/' + $WorkOrder) -Headers $AuthHeader -ContentType $contentType -ErrorAction Stop
        #     Write-Verbose "Project List Retrieved!"
        #     # Building new Object of results from the GET
        #     foreach ($entry in $Query) {
        #         $Temp = New-Object System.Object
        #         $Temp | Add-Member -MemberType NoteProperty -Name "WorkOrder" -Value $entry.data.Id
        #         $Temp | Add-Member -MemberType NoteProperty -Name "Summary" -Value $entry.data.Summary
        #         $Temp | Add-Member -MemberType NoteProperty -Name "RequestorName" -Value $entry.data.RequestorName
        #         $Temp | Add-Member -MemberType NoteProperty -Name "AssignedTechnician" -Value $entry.data.AssignedTechnician
        #         $Temp | Add-Member -MemberType NoteProperty -Name "EnteredDate" -Value $entry.data.RequestorEnteredDate
        #         $Temp | Add-Member -MemberType NoteProperty -Name "CompletedDate" -Value $entry.data.EnteredCompletionDate
        #         $Temp | Add-Member -MemberType NoteProperty -Name "Priority" -Value $entry.data.Priority
        #         $Temp | Add-Member -MemberType NoteProperty -Name "Type" -Value $entry.data.Type
        #         $Temp | Add-Member -MemberType NoteProperty -Name "SubType" -Value $entry.data.SubType
        #         $Temp | Add-Member -MemberType NoteProperty -Name "Category" -Value $entry.data.Category
        #         $Temp | Add-Member -MemberType NoteProperty -Name "Company" -Value $entry.data.UdfLookup1
        #         $Temp | Add-Member -MemberType NoteProperty -Name "Closed" -Value $entry.data.IsClosed
        #         $Result.Add($Temp) | Out-Null
        #     }
        # }
        # Catch {  
        #     $response = $_.Exception.Response.GetResponseStream()
        #     $reader = New-Object System.IO.StreamReader($response)
        #     $reader.BaseStream.Position = 0
        #     $reader.DiscardBufferedData()
        #     $responseBody = $reader.ReadToEnd();
        #     Write-Host -ForegroundColor Red $_ "---->" $responseBody
        #     Break
        # }
        # $Result
    }

    end {
        $WorkOrder = $Null
        $Query = $Null
        $Temp = $Null
        $response = $Null
        $reader = $Null
        $responseBody = $Null
    }
}

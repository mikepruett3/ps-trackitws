function New-WorkOrder {
    <#
    .SYNOPSIS
        This function creates a new Work Order in Track-it!
    .DESCRIPTION
        This function creates a new Work Order in Track-it!, using the Web API.
    .OUTPUTS
        Creats a variable $Result that is available for use in other cmdlets.
    .EXAMPLE
        > New-WorkOrder
    #>

    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="Medium" 
    )]

    param (
        [Parameter(Mandatory=$True)]
        [String]$Summary,
        [Parameter(Mandatory=$True)]
        [String]$Status,
        [Parameter(Mandatory=$True)]
        [String]$Technician,
        [Parameter(Mandatory=$True)]
        [String]$Requestor,
        [Parameter(Mandatory=$True)]
        [String]$Company,
        [String]$Priority = '03 - Medium',
        [String]$Type = 'Support',
        [String]$SubType,
        [String]$Computer,
        [String]$Category
    )

    begin {
        # Creating Request Body from parameter data
        $Body = New-Object System.Object
        $Body | Add-Member -MemberType NoteProperty -Name "StatusName" -Value $Status
        $Body | Add-Member -MemberType NoteProperty -Name "Summary" -Value $Summary
        $Body | Add-Member -MemberType NoteProperty -Name "AssignedTechnician" -Value $Technician
        $Body | Add-Member -MemberType NoteProperty -Name "RequestorName" -Value $Requestor
        $Body | Add-Member -MemberType NoteProperty -Name "Priority" -Value $Priority
        $Body | Add-Member -MemberType NoteProperty -Name "Type" -Value $Type
        $Body | Add-Member -MemberType NoteProperty -Name "SubType" -Value $SubType
        $Body | Add-Member -MemberType NoteProperty -Name "Category" -Value $Category
        $Body | Add-Member -MemberType NoteProperty -Name "UdfLookup1" -Value $Company
        $Body | Add-Member -MemberType NoteProperty -Name "AssetName" -Value $Computer

        #Creating new Array for result
        $Result = New-Object System.Collections.ArrayList
    }

    process {
        Try {
            # Querying Track-it! Web API
            $Query = Invoke-RestMethod -Method Post -Uri ($RootURI + '/workorder/Create/') -Headers $AuthHeader -ContentType $contentType -Body (ConvertTo-Json $Body) -ErrorAction Stop
            Write-Verbose "Work Order Created!"
            # Building new Object of results from the Post
            $Temp = New-Object System.Object
            $Temp | Add-Member -MemberType NoteProperty -Name "Success" -Value $Query.success
            $Temp | Add-Member -MemberType NoteProperty -Name "WorkOrder" -Value $Query.data.data.Id
            $Temp | Add-Member -MemberType NoteProperty -Name "Status" -Value $Query.data.data.StatusName
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
        $Body = $Null
        $Query = $Null
        $Temp = $Null
        $response = $Null
        $reader = $Null
        $responseBody = $Null
        $Summary = $Null
        $Status = $Null
        $Technician = $Null
        $Requestor = $Null
        $Company = $Null
        $Priority = $Null
        $Type = $Null
        $SubType = $Null
        $Computer = $Null
        $Category = $Null
    }
}

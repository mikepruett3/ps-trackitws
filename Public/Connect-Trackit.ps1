function Connect-Trackit {
    <#
    .SYNOPSIS
        This function creates a Header variable for use with Rest Calls to Track-it! Web API
    .DESCRIPTION
        This function creates a variable, used with other functions and cmdlets
    .PARAMETER Server
        Specify the Track-it! server URL to connect to. (Usually the server's FQDN)
    .PARAMETER Credentials
        Specify the Track-it! Username and Password (Cannot be Domain Account, has to be local Track-it! Technician account)
    .OUTPUTS
        Creats a global variable $Global:Header that is available for use in other cmdlets. It contains the JSON auth session token.
    .EXAMPLE
        > Connect-Trackit -Server TrackIt.corp.net -Credentials "Administrator"
        Initiates a new connection to the Track-it! Web API
    .NOTES
        -- Made Easier with the BetterCredentials Module - https://github.com/Jaykul/BetterCredentials --
    #>

    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="Medium" 
    )]

    param (
        [Parameter(Mandatory=$True)]
        [string]$Server,
        [Parameter(Mandatory=$True)]
        [string]$Credentials
    )

    begin {
        # Ping the server
        try { Test-Connection -ComputerName $Server -Count 1 -ErrorAction Stop > $null }
        catch {
            Write-Error "Count not communicate with $Server"
            Break
        }

        # Slup Credentials (and ask for them, if not stored)
        $Creds = Get-Credential("$Credentials")
        $username = $Creds.GetNetworkCredential().username
        $password = $Creds.GetNetworkCredential().password

        # Setting Global variables used for connecting to the Track-it! Web API
        $Global:RootURI = 'https://' + $Server + '/TrackItWebAPI/api'
        $Global:contentType = "application/json"
    }

    process {
        # Get APIKey from Track-it! Web API
        Try {
            $AuthResult = Invoke-RestMethod -Method GET -Uri ($RootURI + '/login?username=' + $username + '&pwd=' + $password ) -ContentType $contentType -ErrorAction Stop
            $Global:AuthHeader = @{"TrackItAPIKey" = ($AuthResult.data.apiKey)}
            Write-Verbose "Auth Token Generated Successfully"
        }
        Catch {  
            $result = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($result)
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd();
            Write-Host -ForegroundColor Red $_ "---->" $responseBody
            Break
        }
    }

    end {
        $Creds = $Null
        $Credentials = $Null
        $username = $Null
        $password = $Null
        $result = $Null
        $reader = $Null
        $responseBody = $Null
        $AuthResult = $Null
    }
}
function Disconnect-Trackit {
    <#
    .SYNOPSIS
        This cmdlet ends the session created prior with cmdlet Connect-Trackit.
    .DESCRIPTION
        his cmdlet closes the session created with Connect-Trackit and sets the global variable $Global:AuthHeader to NULL
    .EXAMPLE
        > Disconnect-Trackit
        Disconnect the active session.
    #>

    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="Medium" 
    )]

    param ()

    begin {}

    process {}

    end {
        # Cleanup Globally Defined Variables
        Clear-Variable -Name RootURI -Scope Global -ErrorAction SilentlyContinue
        Clear-Variable -Name AuthHeader -Scope Global -ErrorAction SilentlyContinue
        Clear-Variable -Name contentType -Scope Global -ErrorAction SilentlyContinue
    }
}
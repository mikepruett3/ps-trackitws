# PowerShell Track-it! WebService API Tools (ps-trackitws)

Module created to allow for Work Order Operations from Track-it!'s WebService API, via PowerShell Invoke-WebRequest cmdlets. For use with other cmdlets and scripts.

## Installation

Clone the repository into your **$Home\Documents\WindowsPowerShell\Modules** folder (create the Modules folder if you dont have one already)

```powershell
cd $Home\Documents\WindowsPowerShell\Modules\
git clone git@github.com:mikepruett3/ps-trackitws.git
```

Then you can import the custom module into your running shell...

```powershell
Import-Module ps-trackitws
```

## Usage

### Connect to Track-it!'s WebService API

Running this function will create a Global Variable which is used with subsequent functions of this module.

This function is looking for two parameters at runtime...

| Parameter | Description|
|:---|:---|
| Server | The server name (Fully-Qualified) of the server running the Track-it! WebService API instance. |
| Credentials | The credentials used to connect to the Track-it! WebService API. These credentials must be configured with the Technician Role. |

Once you have these Environment Variables, run the following:

```powershell
Connect-Trackit -Server <server-name> -Credentials <username>
```

### Create WorkOrder

Creating a new WorkOrder in Track-it! WebService API can be performed by the following:

```powershell
New-WorkOrder -Summary 'Description of the problem' `
              -Status 'Open' #Cannot create a Closed ticket, must allways be open! `
              -Technician 'Your Name' `
              -Requestor 'Requestors Name' `
              -Company 'Company Name' `
              -Priority 'WorkOrder Priorty' `
              -Category 'WorkOrder Type' `
              -Type 'WorkOrder Type' `
              -SubType 'WorkOrder SubType' `
              -Computer 'Computer or Asset Name (if required)' `
```

### Retrieve WorkOrder

Retrieving an existing WorkOrder in Track-it! WebService API can be performed by the following:

```powershell
Get-WorkOrder -WorkOrder 'WorkOrder Number'
```

### Close WorkOrder

Closing an existing WorkOrder in Track-it! WebService API can be performed by the following:

```powershell
Close-WorkOerder -WorkOrder 'WorkOrder Number'
```

### Disconnecting from Track-it! WebService API

```powershell
Disconnect-Trackit
```


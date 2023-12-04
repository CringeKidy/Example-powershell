# Copyright (c) 2023 Justace Cornelder AkA Wixz Studios
# All rights reserved.

<#
.SYNOPSIS
    This script is for sorting data from an API Requests from randomuser.me.

.NOTES
    Author: Justace Cornelder
    Copyright: (c) 2023 Wixz Studios
    Version: 1.0
#>

#using the Invoke-RestMethod we grab 50 users from randomuser.me to use for your script. 
Write-Host 'Grabbing user information at randomuser.me'
$userResults = Invoke-RestMethod -URI "https://randomuser.me/api/?results=50"

#Creating a Custom Object array cause the Response we get from randomeuser.me has some stuff that is not needed.
#So this is considered as a filter from the response of the API request
$userArray = @()

#This is just filtering the information that we need EG:
#FirstName, LastName, Username, Email, DOB, Location and Cellphone.
foreach($user in $userResults.results){
    $userArray += [PSCustomObject]@{
        firstName = $user.name.first;
        lastName = $user.name.last;
        DOB = $user.dob.date
        userName = $user.login.username;
        email = $user.email
        location = $user.location.city;
        cellPhone = $user.cell
    }
}

#Exporting the information into a readable CSV with it ordered in Alphabetical order using the users first names.
$userArray | Sort-Object firstName | Export-Csv -Path ./UserInformation.csv -Encoding UTF8


write-host "Information has been exported to ./UserInformation.csv"
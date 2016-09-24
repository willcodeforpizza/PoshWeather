<#
    .Synopsis
        Returns if it is raining or not

    .DESCRIPTION
        Queries the openweathermap API and returns if it raining or not
        based on city code

    .PARAMETER ApiKey
        API key for openweathermap
        Get one from http://openweathermap.org/appid#get
    
    .PARAMETER Cityname
       The name of the city to get the weather for

    .PARAMETER Countrycode
        The Country code the city is in
        See here: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements

    .EXAMPLE
       Test-UmbrellaNeeded -ApiKey "f0b35185ec994312bff9c29221f360a7" -Cityname "london" -Countrycode "uk"

    .OUTPUTS
       True or False

    .NOTES
       Written by Martin Howlett @WillCode4Pizza
#>
Function Test-UmbrellaNeeded
{
    Param (

        [Parameter(Mandatory=$true)][string]$ApiKey,
        [Parameter(Mandatory=$true)][string]$Cityname,
        [Parameter(Mandatory=$true)][string]$Countrycode
    )

    $Response = Get-Weather -ApiKey $ApiKey -Cityname $Cityname -Countrycode $Countrycode

    #check if its raining  and return true/false
    if($Response.rain)
    {
        Write-Output $true
    }
    else
    {
       Write-Output $false
    }
}

<#
    .Synopsis
        Gets current weather of provided city

    .DESCRIPTION
        Queries the OpenWeatherMap API with the current city and returns the current weather

    .PARAMETER ApiKey
        API key for openweathermap
        Get one from http://openweathermap.org/appid#get

    .PARAMETER Cityname
        The name of the city to get the weather for

    .PARAMETER Countrycode
        The Country code the city is in
        See here: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements

    .EXAMPLE
       Get-Weather -ApiKey "f0b35185ec994312bff9c29221f360a7" -Cityname "london" -Countrycode "uk"

    .OUTPUTS
       Psobject of weather

    .NOTES
       Written by Martin Howlett @WillCode4Pizza
#>
Function Get-Weather
{
    Param (

        [Parameter(Mandatory=$true)][string]$ApiKey,
        [Parameter(Mandatory=$true)][string]$Cityname,
        [Parameter(Mandatory=$true)][string]$Countrycode
    )

    #create the url from the parameters
    $uri = "http://api.openweathermap.org/data/2.5/weather?q=$Cityname,$Countrycode&appid=$ApiKey"

    #query the API
    $Response = Invoke-RestMethod -uri $uri

    #return response
    Return $Response
}
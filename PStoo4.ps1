#Mihkel Kuusemäe
#10.01.23
#4. Loo PS skript, mis loob failides olevale kasutajale temanimelise kataloogi koos tema andmetega (customers.xml)
#küsib kasutajalt xml failinime
#kui fail pole xml, siis programm annab sellest teada ja küsib uuesti
#kood leiab kliendi nime ning loob sellenimelise kataloogi
#kliendinimelisse kataloogi salvestatakse kõik andmed tekstikujul (tĆ¤isaadress ja kontakt)


$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

$1input = read-host "Faili nimi (.xml)?"


if ($1input -notmatch "$_.xml")
{
    DO
    {
        write-host "Vale fail"
        $1input = read-host "Vale failinimi, proovi uuesti"
    }
   Until ($1input -match "$_.xml")
}

$xml = [xml](Get-Content $dir\$1input)
$rows = $xml.customers.customer

foreach ($row in $rows)
{
    $muutuja = $row.full_name
    New-Item $dir\customers\$muutuja -ItemType Directory
    new-item $dir\customers\$muutuja\$muutuja.txt
    $row >> $dir\customers\$muutuja\$muutuja.txt
}
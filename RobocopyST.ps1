# **************************************************************************************************
#  Robocopy Scripting Tool
# **************************************************************************************************
# AUTOR: Cesar Mendoza
# **************************************************************************************************
# Herramienta sencilla para crear comandos de robocopy por cada subcarpeta de una carpeta raíz. 
# **************************************************************************************************
$rootFolder = "C:\Projects"; 
$scriptsFolder = "C:\Projects\Scripts"; 
$scriptsExtension = ".txt"; 
$logsFolder = "C:\Projects\Logs"; 
$logsExtension = ".txt"; 

$sourceFolder = "\\machine1\folder1"; 
$destFolder = "\\machine2\folder1"; 

Write-Information -MessageData "Inicia el script " -InformationAction Continue; 

$logsExtension = "-" + (Get-Date).Year + "-" + (Get-Date).Month + "-" + (Get-Date).Day + "-" + (Get-Date).Hour + "-" + (Get-Date).Minute + "-LOG" + $logsExtension; 

$subFolders = Get-ChildItem -Path $rootFolder -Directory

foreach ($folder in $subFolders) {
    $logPath = $logsFolder + "\" + $folder + $logsExtension; 
    $command = 'Robocopy "' + $sourceFolder + '\' + $folder + '" "' + $destFolder + '\' + $folder + '" /TEE /S /E /COPYALL /PURGE /ZB /NP /R:2 /W:1 /LOG:"' + $logPath + '"'; 
    $scriptPath = $scriptsFolder + "\" + $folder + $scriptsExtension;     
    $command | Out-File -FilePath $scriptPath -Encoding unicode
    Write-Information -MessageData "Creando robocopy para la carpeta $folder" -InformationAction Continue; 
}

Write-Information -MessageData "Script finalizado." -InformationAction Continue; 

# **************************************************************************************************
#  Robocopy Scripting Tool
# **************************************************************************************************
# AUTOR: Cesar Mendoza
# **************************************************************************************************
# Herramienta sencilla para crear comandos de robocopy por cada subcarpeta de una carpeta raíz. 
# **************************************************************************************************
# PARAMETROS: 
$sourceFolder = "\\localhost\source"; # Nunca finalice con \
$targetFolder = "\\localhost\target"; # Nunca finalice con \
$params = '/TEE /S /E /COPYALL /PURGE /ZB /NP /R:2 /W:1 /LOG:"' # /LOG:Siempre al final. 

$scriptsFolder = "C:\Robocopy\Scripts"; # Nunca finalice con \
$scriptsExtension = ".txt"; 
$logsFolder = "C:\Robocopy\Logs"; # Nunca finalice con \
$logsExtension = ".txt"; 
# **************************************************************************************************
# INICIA EL SCRIPT
Write-Information -MessageData "Inicia el script " -InformationAction Continue; 

$logsExtension = "-" + (Get-Date).Year + "-" + (Get-Date).Month + "-" + (Get-Date).Day + "-" + (Get-Date).Hour + "-" + (Get-Date).Minute + "-LOG" + $logsExtension; 

$subFolders = Get-ChildItem -Path $sourceFolder -Directory

foreach ($folder in $subFolders) {
    $logPath = $logsFolder + "\" + $folder + $logsExtension; 
    $command = 'Robocopy "' + $sourceFolder + '\' + $folder + '" "' + $targetFolder + '\' + $folder + '" ' + $params + $logPath + '"'; 
    $scriptPath = $scriptsFolder + "\" + $folder + $scriptsExtension;     
    $command | Out-File -FilePath $scriptPath -Encoding unicode
    Write-Information -MessageData "Creando robocopy para la carpeta $folder" -InformationAction Continue; 
}

Write-Information -MessageData "Script finalizado." -InformationAction Continue; 

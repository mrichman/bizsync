$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Orders\"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

write-host "Watching for new orders in $($watcher.Path). Saving backups to C:\Orders-Backup"

$changed = Register-ObjectEvent $watcher "Changed" -Action {
   write-host "Changed: $($eventArgs.FullPath)"
   $datestamp = get-date -uformat "%Y%m%d%H%M%S" 
   write-host $datestamp
   copy-item $eventArgs.FullPath "C:\Orders-Backup\$datestamp.txt"
}

$created = Register-ObjectEvent $watcher "Created" -Action {
   write-host "Created: $($eventArgs.FullPath)"
   $datestamp = get-date -uformat "%Y%m%d%H%M%S" 
   write-host $datestamp
   copy-item $eventArgs.FullPath "C:\Orders-Backup\$datestamp.txt"
}

$deleted = Register-ObjectEvent $watcher "Deleted" -Action {
   write-host "Deleted: $($eventArgs.FullPath)"
}

$renamed = Register-ObjectEvent $watcher "Renamed" -Action {
   write-host "Renamed: $($eventArgs.FullPath)"
}

Read-Host "Press any key to exit..."
exit

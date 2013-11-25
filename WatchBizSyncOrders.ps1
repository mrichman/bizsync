$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Orders\"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

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

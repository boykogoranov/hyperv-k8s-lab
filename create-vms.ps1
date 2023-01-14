$masters = "master01", "master02", "master03"
$workers = "worker01", "worker02"
$loadbalancer = "lb1"

Write-Host "Creating K8s VMs..."

foreach ($vmName in $loadbalancer) {
    $vhdPath = 'C:\Users\Public\Documents\Hyper-V\Virtual hard disks\' + $vmName + '.vhdx'
    Write-Host $vmName + " created."
    New-VM -Name $vmName -MemoryStartupBytes 2GB -Generation 1 -NewVHDPath $vhdPath -NewVHDSizeBytes 10GB -SwitchName "bridged"
    Set-VM -Name $vmName -AutomaticCheckpointsEnabled false -StaticMemory
    Set-VMDvdDrive -VMName $vmName -Path C:\Users\boyko\Desktop\downloads\CentOS-7-x86_64-Minimal-2009.iso
    Set-VMProcessor -VMName $vmName -Count 2
}

foreach ($vmName in $masters) {
    $vhdPath = 'C:\Users\Public\Documents\Hyper-V\Virtual hard disks\' + $vmName + '.vhdx'
    Write-Host $vmName + " created."
    New-VM -Name $vmName -MemoryStartupBytes 3GB -Generation 1 -NewVHDPath $vhdPath -NewVHDSizeBytes 10GB -SwitchName "bridged"
    Set-VM -Name $vmName -AutomaticCheckpointsEnabled false -StaticMemory
    Set-VMDvdDrive -VMName $vmName -Path C:\Users\boyko\Desktop\downloads\CentOS-7-x86_64-Minimal-2009.iso
    Set-VMProcessor -VMName $vmName -Count 2
}

foreach ($vmName in $workers) {
    $vhdPath = 'C:\Users\Public\Documents\Hyper-V\Virtual hard disks\' + $vmName + '.vhdx'
    Write-Host $vmName + " created."
    New-VM -Name $vmName -MemoryStartupBytes 8GB -Generation 1 -NewVHDPath $vhdPath -NewVHDSizeBytes 10GB -SwitchName "bridged"
    Set-VM -Name $vmName -AutomaticCheckpointsEnabled false -StaticMemory
    Set-VMDvdDrive -VMName $vmName -Path C:\Users\boyko\Desktop\downloads\CentOS-7-x86_64-Minimal-2009.iso
    Set-VMProcessor -VMName $vmName -Count 2
}
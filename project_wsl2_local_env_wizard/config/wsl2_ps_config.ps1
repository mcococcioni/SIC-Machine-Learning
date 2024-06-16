ECHO "---------------------------------"
ECHO "WSL2 configuration process begins"
ECHO "---------------------------------"
	

if ( -not $PSScriptRoot ) {
	$PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}

try {
	$my_parent_dir = Split-Path $PSScriptRoot -Parent
	
	$conf_file = "project_wsl_conf.sh"
	
	$source = "${my_parent_dir}\local\${conf_file}"
	
	$temp_dir = "seai_project_temp"
	$destination = "C:\${temp_dir}"
	
	New-Item -Path "c:\" -Name "{$temp_dir}" -ItemType "directory" -Force
	New-Item -Path "${destination}" -Name "${conf_file}" -ItemType File -Force
	
	Copy-Item -Path "${source}" -Destination "${destination}" -Force
	ECHO "Configuration files instantiated successfully"

	wsl --update
	wsl --set-default-version 2
	wsl --install -d Ubuntu-22.04

}
catch {
	ECHO $_.Exception.Message
}

Configuration Install {
    Import-DscResource -ModuleName 'PSDscResources'
    Node localhost {
        WindowsFeatureSet ExampleWindowsFeatureSet {
            Name                 = @(
                'Web-Server'
		'Web-WebServer'
		'Web-Common-Http'
		'Web-Default-Doc'
		'Web-Dir-Browsing'
		'Web-Http-Errors'
		'Web-Static-Content'
		'Web-Health'
		'Web-Http-Logging'
		'Web-Performance'
		'Web-Stat-Compression'
		'Web-Security'
		'Web-Filtering'
		'Web-Basic-Auth'
		'Web-Windows-Auth'
		'Web-App-Dev'
		'Web-Net-Ext'
		'Web-Net-Ext45'
		'Web-AppInit'
		'Web-ASP'
		'Web-Asp-Net'
		'Web-Asp-Net45'
		'Web-ISAPI-Ext'
		'Web-ISAPI-Filter'
		'Web-Includes'
		'Web-WebSockets'
		'Web-Mgmt-Tools'
		'Web-Mgmt-Console'
            )
            Ensure               = 'Present'
            IncludeAllSubFeature = $false
            LogPath              = 'C:\temp\Log.log'
        }
    }
}
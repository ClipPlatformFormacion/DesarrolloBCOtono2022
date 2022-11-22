#Install-Module -Name BcContainerHelper -Force

$artifactUrl = Get-BCArtifactUrl -country es -select Latest -type Sandbox

New-BcContainer -accept_eula `
                -artifactUrl $artifactUrl `
                -auth UserPassword `
                -containerName BC20CU5ES `
                -dns 8.8.8.8 `
                -includeTestLibrariesOnly `
                -includeTestToolkit `
                -updateHosts `
                -useBestContainerOS
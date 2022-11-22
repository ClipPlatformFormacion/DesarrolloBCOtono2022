#Install-Module -Name BcContainerHelper -Force

$artifactUrl = Get-BCArtifactUrl -country es -select Latest -type Sandbox

$splittedArtifactURL = $artifactUrl.Split('/')
$splittedVersion = $splittedArtifactURL[4].Split('.')

$version = $splittedVersion[0]
$cumulative = $splittedVersion[1]
$country = $splittedArtifactURL[5]

$containerName = 'BC' + $version + 'CU' + $cumulative + $country

New-BcContainer -accept_eula `
                -artifactUrl $artifactUrl `
                -auth UserPassword `
                -containerName $containerName `
                -dns 8.8.8.8 `
                -includeTestLibrariesOnly `
                -includeTestToolkit `
                -updateHosts `
                -useBestContainerOS
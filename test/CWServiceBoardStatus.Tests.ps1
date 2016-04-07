# remove module if it exist and re-imports it
$WorkspaceRoot = $(Get-Item $PSScriptRoot).Parent.FullName
Remove-Module "CWServiceBoardStatusCmdLets" -ErrorAction Ignore
Import-Module "$WorkspaceRoot\src\CWServiceBoardStatusCmdLets.psm1" -Force 

Describe 'CWServiceBoardStatus' {

	. "$WorkspaceRoot\test\LoadTestSettings.ps1"
	
	Context 'Get-CWServiceBoardStatus' {
		
		$pstrBoardID = $pstrGenSvc.boardIds[0];
		
		It 'gets board status and check that the results is an array' {
			$boardID = $pstrBoardID;
			$statuses = Get-CWServiceBoardStatus -BoardID $boardID -BaseApiUrl $pstrSvrUrl -CompanyName $pstrSvrCompany -PublicKey $pstrSvrPublic -PrivateKey $pstrSvrPrivate;
			$statuses.GetType().BaseType.Name | Should Be "Array";		
		}
		
		It 'gets board and pipes it through the Select-Object cmdlet for the id property of the first object' {
			$boardID = $pstrBoardID;
			$status = Get-CWServiceBoardStatus -BoardID $boardID -BaseApiUrl $pstrSvrUrl -CompanyName $pstrSvrCompany -PublicKey $pstrSvrPublic -PrivateKey $pstrSvrPrivate | Select-Object boardId -First 1;
			$status | Select-Object -ExpandProperty boardId | Should Be $boardID;		
		}
	
	}

} 
$env:POSH_GIT_ENABLED = $true
Set-PoshPrompt -Theme C:\Users\abbas\AppData\Local\pwsh\theme.json

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# show autocomplete
Set-PSReadLineOption -PredictionSource History

# path autocomplete
Import-Module cd-extras
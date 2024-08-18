# Define the include and exclude lists
$includeList = @{}
$excludeList = @("random mobs", "merchants", "respawn", "Hand of the Maestro", "Note", "Arantir's Ring", "Ruby", "elemental", "Permafrost", "Diary Page")

# Get all the Markdown files
$files = Get-ChildItem -Path "C:\Users\william.babij\Desktop\epic" -Filter "*.md" -Recurse

# Create a new file for the debugging output
$debugOutputFile = Join-Path -Path (Get-Location) -ChildPath "debugging_output.txt"
"" | Out-File $debugOutputFile  # Clear the file

# Build the include list
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $matches = [regex]::Matches($content, '\[(.*?)\]\(/(zone|item|npc|faction|script-entities)/(\d+)\)')
    foreach ($match in $matches) {
        $key = $match.Groups[1].Value
        $value = $match.Value
        if (!$includeList.ContainsKey($key)) {
            $includeList[$key] = $value
            Add-Content -Path $debugOutputFile -Value "Adding to include list: $key => $value"
        }
    }
}

Add-Content -Path $debugOutputFile -Value "Include list contains $($includeList.Count) entries."

# Replace the non-linked words with linked ones, ignoring lines with checkboxes
foreach ($file in $files) {
    $contentLines = Get-Content -Path $file.FullName
    $updatedContent = @()
    foreach ($line in $contentLines) {
        if ($line -notmatch '^\s*\[[ x]\]') {
            $replacements = @()
            foreach ($entry in $includeList.GetEnumerator()) {
                $key = $entry.Key
                $value = $entry.Value
                if (!$excludeList.Contains($key)) {
                    # Ensure we only replace exact standalone words that are not part of a link
                    $pattern = "(?<!\[)$key(?!\]\(/)"
                    $replacement = [regex]::Replace($line, $pattern, $value)
                    if ($replacement -ne $line) {
                        $replacements += "Replaced '$key' with '$value'"
                        $line = $replacement
                    }
                }
            }
            if ($replacements.Count -gt 0) {
                Add-Content -Path $debugOutputFile -Value "File: $($file.FullName)"
                Add-Content -Path $debugOutputFile -Value $replacements
            }
        }
        $updatedContent += $line
    }
    Set-Content -Path $file.FullName -Value $updatedContent
}


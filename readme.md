Certainly! Below is a README in Markdown format that describes the functionality of the PowerShell script:

# Markdown Link Automation Script

## Overview

This PowerShell script automates the process of linking specific terms to their respective detailed pages in Markdown files located within a specified directory. It is designed to enhance documentation by ensuring that references to items, zones, NPCs, and other entities are consistently linked throughout all Markdown files.

## Features

- **Automatic Link Detection and Creation**: Scans documents for specific terms and automatically converts them into Markdown links if they match entries in a predefined list.
- **Exclusion List**: Ignores certain terms specified in an exclusion list to prevent them from being linked.
- **Checkbox Line Ignorance**: Skips lines containing Markdown checkboxes to preserve task lists or other checkbox-utilizing formats. **This is not working as expected**
- **Debugging Output**: Generates a debugging output file that logs the details of the operations performed, including what terms were linked and in which files changes were made.

## How It Works

1. **Initialization**:

   - The script initializes by defining include and exclude lists. The include list is populated with terms found in the Markdown files that match a specific link format.
   - All Markdown files within the specified directory are loaded for processing.

2. **Building the Include List**:

   - Each file is scanned for links matching a predefined pattern (e.g., `[Term](/type/id)`).
   - These links are added to the include list if they are not already present.

3. **Processing Files**:

   - The script reads each file line by line.
   - It skips lines containing Markdown checkboxes. **This is not working as expected**
   - For other lines, it replaces exact matches of terms (that are not already part of a link and not in the exclude list) with their corresponding Markdown links from the include list.

4. **Logging**:
   - Details of the operations, including additions to the include list and replacements made in files, are logged in a debugging output file.

## Usage

To run the script, ensure you have PowerShell installed and execute the script from the command line, specifying the path to the directory containing your Markdown files.

## Requirements

- PowerShell 5.0 or higher
- Access to the directory containing Markdown files

## Limitations

- The script currently only supports Markdown files (.md).
- It is designed to work with specific link formats and may require adjustments for different Markdown or link formats.
- Keep an eye out for misspelling in your markdown as it will miss these.
- Also look for cases where you may have common words mixed with uncommon words. Diary vs Neh'Ashiir's Diary.

## Conclusion

This script is a powerful tool for maintaining consistent and accurate documentation in Markdown files, especially useful for large projects with numerous references to various entities.

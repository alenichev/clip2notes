-- Note template
set noteHTMLText to "<pre style=\"font-family:Helvetica,sans-serif;\">" & (the clipboard as Unicode text) & "</pre>"

tell application "Notes"
	activate
	set thisAccountName to my getNameOfTargetAccount("Choose an account:")
	set thisFolderName to my getNameOfTargetFolder("Choose a folder:")
	--ask title
	display dialog "Enter the title for the new note:" default answer "New Note" with icon 1 with title "New Note with Clipboard"
	set the noteTitle to the text returned of the result
	--make note
	tell account thisAccountName
		make new note at folder thisFolderName with properties {name:noteTitle, body:noteHTMLText}
	end tell
end tell

-- Get account
on getNameOfTargetAccount(thisPrompt)
	tell application "Notes"
		if the (count of accounts) is greater than 1 then
			set theseAccountNames to the name of every account
			set thisAccountName to (choose from list theseAccountNames with prompt thisPrompt)
			if thisAccountName is false then error number -128
			set thisAccountName to thisAccountName as string
		else
			set thisAccountName to the name of account 1
		end if
		return thisAccountName
	end tell
end getNameOfTargetAccount

-- Get folder
on getNameOfTargetFolder(thisPrompt)
	tell application "Notes"
		if the (count of folders) is greater than 1 then
			set theseFolderNames to the name of every folder
			set thisFolderName to (choose from list theseFolderNames with prompt thisPrompt)
			if thisFolderName is false then error number -128
			set thisFolderName to thisFolderName as string
		else
			set thisFolderName to the name of folder 1
		end if
		return thisFolderName
	end tell
end getNameOfTargetFolder
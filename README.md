# izNotes

IzNotes is a simple note taking application designed to incorporate the use of Firebase Realtime Database.

## App Architecture

- All the firebase operations code is in the NotesModel class.
- Keeping everything in one place allows for easy modifications to any Firestore query.
- Notes model takes the data from the database of all the different notes.
- Its going to pass it to the viewController and display it all in a tableView.
- We then pass the data through a notes structure using instances.  
- Put all the notes instances into an array and pass the whole array to the viewController.
- When the user taps on a specific note from the tableView it opens up a detail viewController.
- On the detail viewController the user can see the title/content and can edit, save or delete that note. 
- Then all that information makes its way to the NotesModel class so it can write that data to the database.

## Screenshot

![](ccc.png)






//
//  NotesModel.swift
//  izNotes
//
//  Created by Izzat Jabali on 12/1/21.
//

import Foundation
import Firebase

protocol NotesModelProtocol {
    
    func notesRetrieved(notes:[Note])
}

class NotesModel {
    
    var delegate:NotesModelProtocol?
    
    func getNotes() {
        
        // Get a referenec to the database
        let db = Firestore.firestore()
        
        // Get all the notes
        db.collection("notes").getDocuments { (snapshot, error) in
            
            // Check for eeors
            if error == nil && snapshot != nil {
                
                var notes = [Note]()
                
                // Parse documents into notes
                for doc in snapshot!.documents {
                    
                    let createdAtDate:Date = Timestamp.dateValue(doc["createdAt"] as! Timestamp)()
                    
                    let lastUpdatedAtDate:Date = Timestamp.dateValue(doc["lastUpdatedAt"] as! Timestamp)()
                    
                    let n = Note(docId: doc["docId"] as! String, title: doc["title"] as! String, body: doc["body"] as! String, isStarred: doc["isStarred"] as! Bool, createdAt: createdAtDate, lastUpdatedAt: lastUpdatedAtDate)
                    
                    notes.append(n)
                }
                
                // Call the delegate and pass back the notes in the main thread
                DispatchQueue.main.async {
                    self.delegate?.notesRetrieved(notes: notes)
                }
            }
        }
    }
}



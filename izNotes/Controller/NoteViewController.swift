//
//  NoteViewController.swift
//  izNotes
//
//  Created by Izzat Jabali on 12/1/21.
//

import UIKit

class NoteViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    var note:Note?
    var notesModel:NotesModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        if note != nil {
            
            titleTextField.text = note?.title
            bodyTextView.text = note?.body
        }
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
    }
    
}

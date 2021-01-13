//
//  MainViewController.swift
//  izNotes
//
//  Created by Izzat Jabali on 12/1/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starButton: UIBarButtonItem!
    
    private var notesModel = NotesModel()
    private var notes = [Note]()
    
    private var isStarFiltered = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delgatye and datasource for the tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set self as the delegate for the notes Model
        notesModel.delegate = self
        
        // Set the status of the star filter button
        setStarFilterButton()
        
        // Retrieve all notes according to star filter

        if isStarFiltered {
            notesModel.getNotes(true)
        } else {
            notesModel.getNotes()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let noteViewVontroller = segue.destination as! NoteViewController
        
        // If the user has selected a row, transistion to notes vc
        if tableView.indexPathForSelectedRow != nil {
            
            // Set the note and notes model properties of the note vc
            noteViewVontroller.note = notes[tableView.indexPathForSelectedRow!.row]
            
            // Deselect the selected row so that it doesnt interfere with new not creation
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)
            
        }
        
        // Weather its a new note or a selected note, we still want ot pass through the notes model
            noteViewVontroller.notesModel = self.notesModel
        }
    
    func setStarFilterButton() {
        
        let imageName = isStarFiltered ? "star.fill" : "star"
        starButton.image = UIImage(systemName: imageName)
    }
    
    @IBAction func startFilterTapped(_ sender: UIBarButtonItem) {
        
        // Toggle the star filter status
        isStarFiltered.toggle()
        
        // Run the query
        isStarFiltered ? notesModel.getNotes(true) : notesModel.getNotes()
        
        // Update the star button
        setStarFilterButton()
        
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        // TODO: Customize cell
        
        let titleLabel = cell.viewWithTag(1) as? UILabel
        titleLabel?.text = notes[indexPath.row].title
        
        let bodyLabel = cell.viewWithTag(2) as? UILabel
        bodyLabel?.text = notes[indexPath.row].body
        
        return cell
    }
}

extension MainViewController: NotesModelProtocol {
    
    func notesRetrieved(notes: [Note]) {
        
        // Set notes property and refresh the tableView
        self.notes = notes
        
        tableView.reloadData()
    }
}

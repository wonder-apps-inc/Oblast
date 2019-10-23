//
//  politicsTableViewController.swift
//  OblastApp
//
//  Created by Jackie on 8/6/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit
import Firebase

//grocerylisttableVC
class politicsTableViewController: UITableViewController {
    
    // MARK: Constants
    let listToUsers = "ListToUsers"
    let ref = Database.database().reference(withPath: "mass-politics")
    
    
    // MARK: Properties
    var items: [politicsItem] = []
    var  user: User!
    var userCountBarButtonItem: UIBarButtonItem!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelectionDuringEditing = false
//        userCountBarButtonItem = UIBarButtonItem(title: "1", style: .plain, target: self, action: #selector(userCountButtonDidTouch))
//        userCountBarButtonItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = userCountBarButtonItem
        
        user = User(uid: "FakeId", email: "hungry@person.food")
        // 1
        ref.observe(.value, with: { snapshot in
            // 2
            var newItems: [politicsItem] = []
            
            // 3
            for child in snapshot.children {
                // 4
                if let snapshot = child as? DataSnapshot,
                    let politicsItem = politicsItem(snapshot: snapshot) {
                    newItems.append(politicsItem)
                }
            }
            
            // 5
            self.items = newItems
            self.tableView.reloadData()
        })
        
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let politicsItem = items[indexPath.row]

            cell.textLabel?.text = politicsItem.name
        cell.detailTextLabel?.text = politicsItem.addedByUser
        
        toggleCellCheckbox(cell, isCompleted: politicsItem.completed)
        return cell
    }
    
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
            cell.detailTextLabel?.textColor = .gray
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let politicsItem = items[indexPath.row]
            politicsItem.ref?.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        var politicsItem = items[indexPath.row]
        let toggledCompletion = !politicsItem.completed
        
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        politicsItem.completed = toggledCompletion
        tableView.reloadData()
    }


    @IBAction func addButtonDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Comment", message: "Add a comment", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first,
                let text = textField.text else {return}
            let polIem = politicsItem(name: text, addedByUser: self.user.email, completed: false)
            let politicsItemRef = self.ref.child(text.lowercased())
            politicsItemRef.setValue(polIem.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func userCountButtonDidTouch() {
        performSegue(withIdentifier: listToUsers, sender: nil)
    }

}

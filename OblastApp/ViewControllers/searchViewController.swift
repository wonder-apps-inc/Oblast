//
//  homepageViewController.swift
//  Faxtion Version 1- Single-View
//
//  Created by Egbert Sayers on 3/30/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//


/*
 
 Going to get the search bar working in the storyboard first, then change verything over to progmatic code. NO longer using storyboards
 
 
 NEED TO ADD THE LABEL in the table view TO SHOW WHAT STATE THE TOWN IS FROM.
 
 
 Goals:
 
 Create FireBase DB.
 Create Log In FB stuff
 Hook up LogIn VC.
-When click on the town cell it takes you to 'forums' screen.
 
 
 */

import UIKit
import Firebase

class searchViewController: UITableViewController, UISearchBarDelegate {



    var zipCodesArray = [zipCodes]()
    var filteredZipCodes = [zipCodes]()
    var inSearchMode = false
    
    var zipCodesVar: zipCodes!
    
    let searchController = UISearchController(searchResultsController: nil)

    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBar.returnKeyType = UIReturnKeyType.done
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        parseZipCodeJSON()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        

    }
    
    //something off with the zipCode json file? it works fine with the work csv file.
    func parseZipCodeJSON() {
        
        if let url = Bundle.main.url(forResource: "zipcodeJSON", withExtension: "json") {
       // if let url = Bundle.main.url(forResource: "csvjson", withExtension: "json") {
            do {
                let date = Date()
                let data = try Data(contentsOf: url)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    
                    (json["results"] as? [[String:Any]])?.forEach { j in
                        if let name = j["identifier"] as? String, let id = j["id"] as? Int, let state = j["State"] as? String {
                            
                            
                            let sign = zipCodes(townName: name, zipCode: id, state:state)
                            zipCodesArray.append(sign)
                        }
                    }
                    
                }
                print("Took", Date().timeIntervalSince(date))
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func searchBarIsEmpty() -> Bool {
        //Returns true if empty or nil
        
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredZipCodes = zipCodesArray.filter({(zipCodes : zipCodes) -> Bool in return
            String(zipCodes.zipCode).contains(searchText)
            //townName.lowercased().contains(searchText.lowercased())
//            String(zipCodes.zipCode).contains(searchText)
            //            zipCodes.zipCode
            
            
        })
        tableView.reloadData()
    }
//
//    func filterContentForSearchInt(_searchZip: Int, scope: String = ) {
//        filteredZipCodes = zipCodesArray.filter({ (zipCodes : zipCodes) -> Bool in
//            zipCodes.zipCode
//        })
//    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            inSearchMode = true
            filteredZipCodes = zipCodesArray.filter{$0.townName.range(of: searchBar.text!, options: .caseInsensitive) != nil}
//            filteredZipCodes = zipCodesArray.filter{$0.String(zipCode).range(of: searchBar.text!)}
            tableView.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if inSearchMode {
            return filteredZipCodes.count
        }

        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zipCode", for: indexPath) as! zipCodeSearchCell
        //as! SignTableViewCell
        
        
        
        let zip: zipCodes
        
        if inSearchMode {
            zip = filteredZipCodes[indexPath.row]
        } else {
            zip = zipCodesArray[indexPath.row]
        }
        //using configure cell instead of this. change back to this if it doesn;t work.
        //        cell.textLabel!.text = sign.signName
        //        cell.detailTextLabel!.text = candy.category
        cell.configureTableCell(zipCode: zip)
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signIn", let controller = (segue.destination as? UINavigationController)?.topViewController as? searchViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let zip: zipCodes
                if inSearchMode {
                    zip = filteredZipCodes[indexPath.row]
                } else {
                    zip = zipCodesArray[indexPath.row]
                }
                //                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                //   let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                //Dictionary button view, is dictionarytableview, the main table view click on is detail view. maybe need another segue with button.
                
                
                controller.zipCodesVar = zip
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    


}


extension searchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

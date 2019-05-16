//
//  homepageViewController.swift
//  Faxtion Version 1- Single-View
//
//  Created by Egbert Sayers on 3/30/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit

class searchViewController: UIViewController, UISearchBarDelegate {
    
    
    var zipCodesArray = [zipCodes]()
    var filteredZipCodes = [zipCodes]()
    var inSearchMode = false
    
    let searchController = UISearchController(searchResultsController: nil)

    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBar.returnKeyType = UIReturnKeyType.done

        parseZipCodeJSON()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        

    }
    
    
    func parseZipCodeJSON() {
        
        //        if let url = Bundle.main.url(forResource: "LASsignsJSON", withExtension: "json") {
        if let url = Bundle.main.url(forResource: "zipcodeJSON", withExtension: "json") {
            do {
                let date = Date()
                let data = try Data(contentsOf: url)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    
                    (json["results"] as? [[String:Any]])?.forEach { j in
                        if let townName = j["identifier"] as? String, let zipcode = j["id"] as? Int {
                            
                            
                            let zipCode = zipCodes(townName:townName, zipCode: zipcode)
                            zipCodesArray.append(zipCode)
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
        filteredZipCodes = zipCodesArray.filter({(zipCodes : zipCodes) -> Bool in return zipCodes.townName.lowercased().contains(searchText.lowercased())
            
        })
//        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
//            tableView.reloadData()
        } else {
            inSearchMode = true
            filteredZipCodes = zipCodesArray.filter{$0.townName.range(of: searchBar.text!) != nil}
            
//            tableView.reloadData()
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

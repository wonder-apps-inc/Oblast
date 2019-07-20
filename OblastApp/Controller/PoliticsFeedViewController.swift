//
//  PoliticsFeedView.swift
//  OblastApp
//
//  Created by Jackie Norstrom on 7/20/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit

class PoliticsFeedViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "JokeCellTableViewCell") as! JokeCellTableViewCell
        
    }
    
}

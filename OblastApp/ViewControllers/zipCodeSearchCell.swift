//
//  zipCodeSearchCell.swift
//  OblastApp
//
//  Created by Jackie on 5/20/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit

class zipCodeSearchCell: UITableViewCell {
    
    
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipNumberLabel: UILabel!
    
    var zipCodes: zipCodes!
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    func configureTableCell(zipCode: zipCodes) {
        
        self.zipCodes = zipCode
        zipCodeLabel.text = self.zipCodes.townName.capitalized
        //        signImage.image = UIImage(named: "\(self.signs.signNumber)")
        stateLabel.text = self.zipCodes.state.uppercased()
        zipNumberLabel.text = String(zipCodes.zipCode)
    }

    
    
}

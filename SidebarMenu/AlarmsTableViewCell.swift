//
//  AlarmsTableViewCell.swift
//  BerryAwake
//
//  Created by Amanda Berryhill on 11/22/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit

class AlarmsTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var alarm_name: UILabel!
    @IBOutlet weak var alarm_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

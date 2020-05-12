//
//  LawyerData.swift
//  lawyers
//
//  Created by hst on 04/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class LawyerData: UITableViewCell {
    
    @IBOutlet weak var fname: UILabel!
    
    @IBOutlet weak var lname: UILabel!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var spec: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

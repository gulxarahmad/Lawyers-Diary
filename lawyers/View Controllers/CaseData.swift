//
//  CaseData.swift
//  lawyers
//
//  Created by hst on 08/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class CaseData: UITableViewCell {
    
    @IBOutlet weak var cname: UILabel!
    
    @IBOutlet weak var courtname: UILabel!
    
    @IBOutlet weak var casetype: UILabel!
    
    @IBOutlet weak var number: UILabel!
    

    var datashow: CaseDataModel?{
        didSet{
            cname.text = datashow?.cname
            courtname.text = datashow?.courtname
            casetype.text = datashow?.casetype
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

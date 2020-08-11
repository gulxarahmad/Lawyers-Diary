//
//  CompleteCasesData.swift
//  lawyers
//
//  Created by hst on 28/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class CompleteCasesData: UITableViewCell {

    @IBOutlet weak var cname: UILabel!
    @IBOutlet weak var courtname: UILabel!

    @IBOutlet weak var casetype: UILabel!
    @IBOutlet weak var status: UILabel!
    var datashow: CompleteCasesModel?{
             didSet{
                 cname.text = datashow?.cname
                 courtname.text = datashow?.courtname
                 casetype.text = datashow?.casetype
                status.text = datashow?.status
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
    @IBAction func DeleteCompleteRequest(_ sender: Any) {
    }
    
}

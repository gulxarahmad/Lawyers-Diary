//
//  ManualCasesData.swift
//  lawyers
//
//  Created by hst on 28/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
protocol ManualCaseDelegate : class  {
    func markcasedone(cell : ManualCasesData)
}
class ManualCasesData: UITableViewCell {
    
    @IBOutlet weak var cname: UILabel!
    
    @IBOutlet weak var courtname: UILabel!
    @IBOutlet weak var casetype: UILabel!
    @IBOutlet weak var clientname: UILabel!
    weak var delegate : ManualCaseDelegate!
  
    var datashow: ManualCasesModel?{
           didSet{
               cname.text = datashow?.cname
               courtname.text = datashow?.courtname
               casetype.text = datashow?.casetype
               clientname.text = datashow?.clientname
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

    @IBAction func actionMarkDone(_ sender: Any) {
        if let del = self.delegate{
                  del.markcasedone(cell: self)
              }
    }
}

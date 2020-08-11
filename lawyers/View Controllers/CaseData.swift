//
//  CaseData.swift
//  lawyers
//
//  Created by hst on 08/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
protocol CaseDataDelegate : class  {
    //func markcasedone(cell : CaseData)
    func sendMessage(cell : CaseData)
}

class CaseData: UITableViewCell {
    
    @IBOutlet weak var cname: UILabel!
    
    @IBOutlet weak var courtname: UILabel!
    
    @IBOutlet weak var casetype: UILabel!
    
    @IBOutlet weak var clientname: UILabel!
    weak var delegate : CaseDataDelegate!
    
    

    var datashow: CaseDataModel?{
        didSet{
            cname.text = datashow?.cname
            courtname.text = datashow?.courtname
            casetype.text = datashow?.casetype
            clientname.text = datashow?.clientname
        }
    }
    
    

    @IBAction func actionMarkDone(_ sender: Any) {
//        if let del = self.delegate{
//                  del.markcasedone(cell: self)
//              }
        
    }
    @IBAction func actionSendMessage(_ sender: Any) {
           if let del = self.delegate{
                     del.sendMessage(cell: self)
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

//
//  ShowRequestData.swift
//  lawyers
//
//  Created by hst on 27/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
protocol MarkCompleteDelegate : class  {
    func markcomplete(cell : ShowRequestData)
    func sendMessage(cell : ShowRequestData)
}

class ShowRequestData: UITableViewCell {
 
    @IBOutlet weak var casetitle: UILabel!
    @IBOutlet weak var courtname: UILabel!
    @IBOutlet weak var casetype: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var completebtn: UIButton!
    @IBOutlet weak var sendmsgbtn: UIButton!
    
    weak var delegate : MarkCompleteDelegate!
    var datashow: ShowRequestModel?{
              didSet{
                  casetitle.text = datashow?.casetitle
                  courtname.text = datashow?.courtname
                  casetype.text = datashow?.casetype
                  status.text = datashow?.status
                if status.text == "Accepted"{
                    status.textColor = UIColor.green
                    completebtn.isHidden = false
                    sendmsgbtn.isHidden = false
                }
                else{
                    status.textColor = UIColor.red
                    completebtn.isHidden = true
                    sendmsgbtn.isHidden = true
                }
              }
          }
    
    @IBAction func MarkAsComplete(_ sender: Any) {
        if let del = self.delegate{
        del.markcomplete(cell: self)
              }
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



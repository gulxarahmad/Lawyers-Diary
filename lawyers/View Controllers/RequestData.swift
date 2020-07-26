//
//  RequestData.swift
//  lawyers
//
//  Created by hst on 26/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

protocol RequestDataDelegate : class  {
    func acceptCaseRequest(cell : RequestData)
}

class RequestData: UITableViewCell {
    

    @IBOutlet weak var casetitle: UILabel!
    @IBOutlet weak var courtname: UILabel!
    @IBOutlet weak var casetype: UILabel!
    @IBOutlet weak var city: UILabel!
    weak var delegate : RequestDataDelegate!
    var datashow: RequestDataModel?{
           didSet{
               casetitle.text = datashow?.casetitle
               courtname.text = datashow?.courtname
               casetype.text = datashow?.casetype
               city.text = datashow?.city
           }
       }
    
    @IBAction func actionAccept(_ sender: Any) {
        if let del = self.delegate{
            del.acceptCaseRequest(cell: self)
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

//
//  HistoryCaseData.swift
//  lawyers
//
//  Created by hst on 27/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
protocol DeleteCaseDelegate : class  {
    func deletecase(cell : HistoryCaseData)
}
class HistoryCaseData: UITableViewCell {
    
    @IBOutlet weak var cname: UILabel!
    
    @IBOutlet weak var courtname: UILabel!
    
    @IBOutlet weak var casetype: UILabel!
    
    @IBOutlet weak var clientname: UILabel!
     weak var delegate : DeleteCaseDelegate!
    var datashow: HistoryCaseModel?{
          didSet{
              cname.text = datashow?.cname
              courtname.text = datashow?.courtname
              casetype.text = datashow?.casetype
              clientname.text = datashow?.clientname
          }
      }
    
    @IBAction func DeleteCase(_ sender: Any) {
        if let del = self.delegate{
                del.deletecase(cell: self)
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

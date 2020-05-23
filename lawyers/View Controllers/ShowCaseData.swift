//
//  ShowCaseData.swift
//  lawyers
//
//  Created by hst on 23/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class ShowCaseData: UIViewController {
    
    @IBOutlet weak var clientname: UILabel!
    
    @IBOutlet weak var details: UILabel!
    
    @IBOutlet weak var courtname: UILabel!
    
    @IBOutlet weak var contactnumber: UILabel!
    
    @IBOutlet weak var casetype: UILabel!
    
    var client:String!
    var det:String!
    var court:String!
    var contact:String!
    var type:String!
    override func viewDidLoad() {
        clientname.text = client
        details.text = det
        courtname.text = court
        contactnumber.text = contact
        casetype.text = type
        clientname.sizeToFit()
        details.sizeToFit()
        courtname.sizeToFit()
        casetype.sizeToFit()
        contactnumber.sizeToFit()
        details.numberOfLines = 0
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addtohearing(_ sender: Any) {
        let addhearing:LawyerAddHearing = self.storyboard?.instantiateViewController(withIdentifier: "LAddHearing") as! LawyerAddHearing
    self.navigationController?.pushViewController(addhearing, animated:true)
        addhearing.setcname = client
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

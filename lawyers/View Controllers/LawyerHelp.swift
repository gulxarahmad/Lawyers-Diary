//
//  LawyerHelp.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class LawyerHelp: UIViewController {
    @IBOutlet weak var Message: UITextField!
    
    @IBOutlet weak var number: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submit(_ sender: Any) {
        senddata()
        Message.text = ""
        Message.placeholder = "Enter Your Problem Please"
        number.text = ""
        number.placeholder = "Mobile Number"
    }
    
    func senddata(){
        let currentdate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let dates = formatter.string(from: currentdate)
        let msg = Message.text
        let num = number.text
        let ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                   // Get user value
        let value = snapshot.value as? NSDictionary
        let email = value?["email"] as? String ?? ""
            let ldata = ["Message": msg, "Number":num, "Email": email, "Date of Query": dates] as [String: Any]
        let databaseRef = Database.database().reference()
            databaseRef.child("LawyerQuery").childByAutoId().setValue(ldata)
            self.showmessage("Your Query as been set successfully!. We will get back you soon")
    })
}
          func showmessage(_ errmessage:String)
             {
                 //alert message
                 let alertController = UIAlertController(title: "Hello!", message: errmessage , preferredStyle: .alert)
                 let defaultAction = UIAlertAction(title: "Ok, Done", style: .default, handler: nil)
                 alertController.addAction(defaultAction)
                 
                 present(alertController, animated: true, completion: nil)
              //   error.text=errmessage
               //  error.alpha=1
             }
        
    

}

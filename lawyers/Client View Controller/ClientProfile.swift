//
//  ClientProfile.swift
//  lawyers
//
//  Created by hst on 07/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class ClientProfile: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!

    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    var fname:String!
    var em:String!
    var cit:String!
    var gend:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showprofile()
        // Do any additional setup after loading the view.
    }
    
    func showprofile(){
         let ref: DatabaseReference!
         ref = Database.database().reference()
         let userID = Auth.auth().currentUser?.uid
         ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
           // Get user value
           let value = snapshot.value as? NSDictionary
            self.fname = value?["firstname"] as? String ?? ""
            self.em = value?["email"] as? String ?? ""
            self.cit = value?["City"] as? String ?? ""
            self.gend = value?["Gender"] as? String ?? ""
            
            self.name.text = self.fname
            self.email.text = self.em
            self.city.text = self.cit
            self.gender.text = self.gend
          

           }) { (error) in
             print(error.localizedDescription)
         }
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

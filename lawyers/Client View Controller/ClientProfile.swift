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
    
    @IBOutlet weak var mobile: UILabel!
    var fname:String!
    var em:String!
    var cit:String!
    var gend:String!
    var mob:String!
    
    var lastname:String!
    var userid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.alpha = 1
        self.mobile.alpha = 1
        self.email.alpha = 1
        self.city.alpha = 1
        self.gender.alpha = 1
        self.name.sizeToFit()
        self.mobile.sizeToFit()
        self.email.sizeToFit()
        self.city.sizeToFit()
        self.gender.sizeToFit()
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
            self.lastname = value?["lastname"] as? String ?? ""
            self.userid = value?["ID"] as? String ?? ""
            self.fname = value?["firstname"] as? String ?? ""
            self.em = value?["email"] as? String ?? ""
            self.cit = value?["City"] as? String ?? ""
            self.gend = value?["Gender"] as? String ?? ""
            self.mob = value?["Mobile"] as? String ?? ""
            
            self.name.text = self.fname
            self.email.text = self.em
            self.city.text = self.cit
            self.gender.text = self.gend
            self.mobile.text = self.mob
          

           }) { (error) in
             print(error.localizedDescription)
         }
    }

    @IBAction func goToUpdateProfile(_ sender: Any) {
    let gotoprofile:ClientUpdateProfile = self.storyboard?.instantiateViewController(withIdentifier: "ClientUpdateProfile") as! ClientUpdateProfile
        gotoprofile.getid = userid
        gotoprofile.setlname = lastname
        gotoprofile.setfname = name.text
        gotoprofile.setemail = email.text
        gotoprofile.setmobile = mobile.text
        gotoprofile.gend = gender.text
        gotoprofile.cit = city.text
        self.navigationController?.pushViewController(gotoprofile, animated:true)
    }

}

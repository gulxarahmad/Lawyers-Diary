//
//  LawyerProfile.swift
//  lawyers
//
//  Created by hst on 25/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase
class LawyerProfile: UIViewController {
    @IBOutlet weak var fname: UILabel!
    
    @IBOutlet weak var email: UILabel!

    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var spec: UILabel!
    @IBOutlet weak var exp: UILabel!
    @IBOutlet weak var mobile: UILabel!
    var lastname:String!
    var userid: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        showprofile()

        // Do any additional setup after loading the view.
    }
    
    func showprofile()
    {
        let ref: DatabaseReference!
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                      // Get user value
            let value = snapshot.value as? NSDictionary
            self.lastname = value?["lastname"] as? String ?? ""
            self.userid = value?["ID"] as? String ?? ""
            self.fname.text = value?["firstname"] as? String ?? ""
            self.email.text = value?["email"] as? String ?? ""
            self.mobile.text = value?["Phone Number"] as? String ?? ""
            self.city.text = value?["City"] as? String ?? ""
            self.gender.text = value?["Gender"] as? String ?? ""
            self.spec.text = value?["Specialization"] as? String ?? ""
            self.exp.text = value?["Experience"] as? String ?? ""
            self.fname.alpha = 1
            self.mobile.alpha = 1
            self.email.alpha = 1
            self.city.alpha = 1
            self.gender.alpha = 1
            self.spec.alpha = 1
            self.exp.alpha = 1
            self.fname.sizeToFit()
            self.mobile.sizeToFit()
            self.email.sizeToFit()
            self.spec.sizeToFit()
            self.city.sizeToFit()
            self.exp.sizeToFit()
            self.gender.sizeToFit()
            

            
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
    @IBAction func goToUpdateProfile(_ sender: Any) {
    let gotoprofile:UpdateProfile = self.storyboard?.instantiateViewController(withIdentifier: "LawyerUpdateProfile") as! UpdateProfile
        gotoprofile.getid = userid
        gotoprofile.setlname = lastname
        gotoprofile.setfname = fname.text
        gotoprofile.setemail = email.text
        gotoprofile.setmobile = mobile.text
        gotoprofile.expert = exp.text
        gotoprofile.gend = gender.text
        gotoprofile.cit = city.text
        gotoprofile.spec = spec.text
        self.navigationController?.pushViewController(gotoprofile, animated:true)
    }
    
    

}

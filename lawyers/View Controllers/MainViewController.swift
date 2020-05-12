//
//  MainViewController.swift
//  lawyers
//
//  Created by hst on 07/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkuserlogin()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
   
        func checkuserlogin()
        {
            if Auth.auth().currentUser != nil{
                let userID = Auth.auth().currentUser?.uid
            let ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                     // Get user value
            let value = snapshot.value as? NSDictionary
            let usertype = value?["User Type"] as? String ?? ""
                                      
                                     //  print(emails)
            if usertype == "Lawyer"{
            let home = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! LawyerHome
            self.navigationController?.pushViewController(home, animated: true)
        }
            else{
            let home = self.storyboard?.instantiateViewController(withIdentifier: "CHomeVC") as! Client_Home
            self.navigationController?.pushViewController(home, animated: true)

                }

            })

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

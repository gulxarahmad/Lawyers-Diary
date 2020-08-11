//
//  LawyerHome.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class LawyerHome: UIViewController {
    
    @IBOutlet weak var lawyername: UILabel!
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    var MenuOut = false
    
    
    var fname: String!

    override func viewDidLoad() {
        let ref: DatabaseReference!
                              
                               ref = Database.database().reference()
                               let userID = Auth.auth().currentUser?.uid
                               ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                 // Get user value
                                 let value = snapshot.value as? NSDictionary
                                self.fname = value?["firstname"] as? String ?? ""
                                self.lawyername.text = self.fname
   

                                 })
                               
     
        
        super.viewDidLoad()

    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func GoMessages(_ sender: Any) {
        let msg = self.storyboard?.instantiateViewController(withIdentifier: "LMessages") as! LawyerMessages
                self.navigationController?.pushViewController(msg, animated: true)

    }
    
    @IBAction func GoNotification(_ sender: Any) {
    let notif = self.storyboard?.instantiateViewController(withIdentifier: "LNotification") as! LawyerNotifications
    self.navigationController?.pushViewController(notif, animated: true)
    }
    
    @IBAction func GoDiary(_ sender: Any) {
    let diary = self.storyboard?.instantiateViewController(withIdentifier: "LDiary") as! LawyerDiary
    self.navigationController?.pushViewController(diary, animated: true)
    }
    @IBAction func GoLaws(_ sender: Any) {
    let laws = self.storyboard?.instantiateViewController(withIdentifier: "Laws") as! Laws
    self.navigationController?.pushViewController(laws, animated: true)
    }
    
    @IBAction func Logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("Sign Out successful")
            let main = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! MainViewController
                  self.navigationController?.pushViewController(main, animated: true)
             }
        catch{
            print("There is a problem in Sign Out")
        }
        
    }
    
    
    
    @IBAction func SideMenu(_ sender: Any) {
        
        if MenuOut == false{
            
            leading.constant = 150
            trailing.constant = -150
            MenuOut = true
            
        }
        else{
            
            leading.constant = 0
            trailing.constant = 0
            MenuOut = false
            
        }
        
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn,  animations: {
            self.view.layoutIfNeeded()
        })
        
    }
}


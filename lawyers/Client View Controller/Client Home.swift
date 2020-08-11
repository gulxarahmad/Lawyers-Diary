//
//  Client Home.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class Client_Home: UIViewController {
    
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var clientname: UILabel!
    
    var MenuOut = false
    var fname:String!
    
    override func viewDidLoad() {
        let ref: DatabaseReference!
                                     
                                      ref = Database.database().reference()
                                      let userID = Auth.auth().currentUser?.uid
                                      ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                        // Get user value
                                        let value = snapshot.value as? NSDictionary
                                       self.fname = value?["firstname"] as? String ?? ""
                                       print(self.fname)
                                       self.clientname.text = self.fname
          

                                        })
                                      
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func GoFindLawyer(_ sender: Any) {
        let findlawyer = self.storyboard?.instantiateViewController(withIdentifier: "FindLawyer") as! FindLawyer
                self.navigationController?.pushViewController(findlawyer, animated: true)
    }
    @IBAction func GoMessages(_ sender: Any) {
        let msg = self.storyboard?.instantiateViewController(withIdentifier: "CMessages") as! ClientMessages
                self.navigationController?.pushViewController(msg, animated: true)
    }
    @IBAction func GoNotification(_ sender: Any) {
        let notif = self.storyboard?.instantiateViewController(withIdentifier: "CNotification") as! ClientNotifications
                self.navigationController?.pushViewController(notif, animated: true)
    }
    @IBAction func GoLaws(_ sender: Any) {
        let law = self.storyboard?.instantiateViewController(withIdentifier: "Laws") as! Laws
                self.navigationController?.pushViewController(law, animated: true)
    }
    

    @IBAction func LogOut(_ sender: Any) {
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




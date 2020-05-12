//
//  ClientLogin.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ClientLogin: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    //@IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
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
    func validatefields() -> String? {
                   
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
                return "Please Fill all Fields"
            }
                return nil
        
    }

    @IBAction func Signin(_ sender: Any) {
        let error = validatefields()
                     if error != nil
                     {
                         self.showerror(error!)
                     }
                     else
                     {
                     // self.error.alpha = 0
                         let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                         let psw = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                      Auth.auth().signIn(withEmail: em, password:psw){
                          (result, error) in
                          if error != nil
                          {
                              self.showerror(error?.localizedDescription ?? "Login Error")
                          }
                          else
                          {
                              let ref: DatabaseReference!
                             
                              ref = Database.database().reference()
                              let userID = Auth.auth().currentUser?.uid
                              ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                // Get user value
                                let value = snapshot.value as? NSDictionary
                                let user = value?["User Type"] as? String ?? ""
                                if user == "Client"{
                                    let home = self.storyboard?.instantiateViewController(withIdentifier: "CHomeVC") as! Client_Home
                                            self.navigationController?.pushViewController(home, animated: true)
                                }
                                else{
                                    self.showerror("You are Not a Client. Please Try in Lawyer Login")
                                    do{
                                        try Auth.auth().signOut()
                                        
                                        }
                                        catch {
                                        print ("There is an error")
                                        
                                    }

                                }

                               

                                }) { (error) in
                                  print(error.localizedDescription)
                              }

                              
                         //   self.transitiontoHome(userID!)
                            }
                          
                      }
                  }
              
          }
          func showerror(_ errmessage:String)
          {
            let alertController = UIAlertController(title: "Message", message: errmessage , preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
             // error.text=errmessage
            //error.alpha=1
          }

    
}

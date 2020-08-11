//
//  LoginViewController.swift
//  lawyers
//
//  Created by hst on 27/02/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    var firstname: String!
    //@IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  checkuserlogin()

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
    @IBAction func Loginclick(_ sender: Any) {

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
                        ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                          // Get user value
                          let value = snapshot.value as? NSDictionary
                         let usertype = value?["User Type"] as? String ?? ""
                            self.firstname = value?["lastname"] as? String ?? ""
                           // print(self.firstname)
                           
                          //  print(emails)
                            if usertype == "Lawyer"{
                                self.transitiontoHome()
                            }
                            else
                            {
                                self.showerror("You are not a Lawyer. Please Try in Client Login")
                            do{
                                try Auth.auth().signOut()
                                
                                }
                                catch {
                                print ("There is an error")
                                
                                }
                            }
                           // self.transitiontoHome(userID!)

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
        //alert message
        let alertController = UIAlertController(title: "Message", message: errmessage , preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
     //   error.text=errmessage
      //  error.alpha=1
    }
    func transitiontoHome()
    {
  let home = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! LawyerHome
     //   home.fname = self.firstname
        self.navigationController?.pushViewController(home, animated: true)
        

        
    }


}
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

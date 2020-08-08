//
//  Forget Password.swift
//  lawyers
//
//  Created by hst on 24/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase
class Forget_Password: UIViewController {

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validatefields() -> String? {
                   
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
                return "Please Fill all Fields"
            }
        let vemail=email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isValidEmail(vemail) == false
               {
                   return "Email Format is Invalid"
               }
        return nil
        
    }
    
    @IBAction func sendForgotPassword(_ sender: Any) {
        let error = validatefields()
        if error != nil
        {
            self.showerror(error!)
        }
        else
        {
            let auth = Auth.auth()
            auth.sendPasswordReset(withEmail: email.text!){ (error) in
                if let error = error {
                    self.showerror(error.localizedDescription)
            }
                else {
                    self.showerror("The forget passowrd link send to your email")
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

    }


}

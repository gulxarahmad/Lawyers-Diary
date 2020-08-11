//
//  LawyerAddHearing.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class LawyerAddHearing: UIViewController {

    @IBOutlet weak var cname: UITextField!
    
    @IBOutlet weak var agenda: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    var setcname:String!
    var CaseID: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        cname.text = setcname

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
    
    @IBAction func submit(_ sender: Any) {
        savedata()
        agenda.text = ""
        agenda.placeholder = "Type Your Agenda"
    }
    
    func savedata()
    {
        let error = validatefields()
        if error != nil
        {
            self.showmessage(error!)
        }
        else
        {
            
            let name = cname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let agend = agenda.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let hdate = date.date
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.dateFormat = "MMM, dd, YYYY h:mm a"
            let hearingdate = formatter.string(from: hdate)

           // self.uploadprofileimage(self.profilepic.image!, em){url in
            let ref: DatabaseReference!
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                    // Get user value
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String ?? ""
                let hid = UUID().uuidString
                let ldata = ["Hearing ID":hid,"Case ID": self.CaseID,"Case Title": name, "Agenda":agend, "Hearing Date": hearingdate, "Email": email] as [String: Any]
            let databaseRef = Database.database().reference()
            databaseRef.child("Hearings").childByAutoId().setValue(ldata)
             
                
                self.showmessage("Your Hearings has added")
               
            })
            {
                (error) in self.showmessage(error.localizedDescription)
            }
        }
        
    }
    func validatefields() -> String? {
            
          if cname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || agenda.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
               
            {
                return "Please Fill all Fields"
            }
           return nil
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

//
//  AddNewController.swift
//  lawyers
//
//  Created by Apple on 10/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class AddNewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var titleField:UITextField!
      @IBOutlet var bodyField:UITextField!
      @IBOutlet var datePicker:UIDatePicker!
      
      public var completion: ((String,String,Date) -> Void)?

      override func viewDidLoad() {
          super.viewDidLoad()
          
          
         
         /* print(UserDefaults.standard.dictionaryRepresentation())
          
          let saveData = UserDefaults.standard.object(forKey: "titleField")
          
         
          if let titlefield = saveData as? String{
              titleField.text = titlefield
             // bodyField.text = data
              
              
          }*/
        
          
          
          titleField.delegate = self
          bodyField.delegate = self

          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
      }
      
     
      
      @IBAction func didTapSaveButton(){
          
         // UserDefaults.standard.set(titleField.text, forKey: "Enter Title")
          
          
         
          if let titleText = titleField.text, !titleText.isEmpty,
              let bodyText = bodyField.text, !bodyText.isEmpty {
              
              let targetDate = datePicker.date
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM, dd, YYYY at hh:mm"
            let rdatetime = formatter.string(from: targetDate)
           let ref: DatabaseReference!
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                       // Get user value
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String ?? ""
            let ldata = ["Reminder Title": titleText, "Reminder Details":bodyText, "Reminder Time and Date": rdatetime, "Email": email] as [String: Any]
            let databaseRef = Database.database().reference()
                databaseRef.child("LawyersReminder").childByAutoId().setValue(ldata)
            self.completion?(titleText,bodyText,targetDate)
            self.showmessage("Reminder Added Successfully")
              

          })
      }
    }
      

      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          //keyboard dissmissed
          textField.resignFirstResponder()
          return true
      }
        func showmessage(_ errmessage:String)
           {
               //alert message
               let alertController = UIAlertController(title: errmessage, message: errmessage , preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "Ok, Done", style: .default, handler: nil)
               alertController.addAction(defaultAction)
               
               present(alertController, animated: true, completion: nil)
            //   error.text=errmessage
             //  error.alpha=1
           }
      
    


}

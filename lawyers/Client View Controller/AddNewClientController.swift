//
//  AddNewClientController.swift
//  lawyers
//
//  Created by Apple on 10/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class AddNewClientController: UIViewController,UITextFieldDelegate {

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
              
              completion?(titleText,bodyText,targetDate)
          }
      }
      

      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          //keyboard dissmissed
          textField.resignFirstResponder()
          return true
      }
      
    


}

//
//  LawyerAddCase.swift
//  lawyers
//
//  Created by hst on 08/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class LawyerAddCase: UIViewController, UITableViewDelegate, UITableViewDataSource  , UITextFieldDelegate{

   
    var type = ["Personal Injury", "Estate Planning", "Bankruptcy", "Intellectual Property", "Employment", "Corporate", "Immigration", "Crime"]
    var ctype : String! = ""

    @IBOutlet weak var cname: UITextField!
    
    @IBOutlet weak var details: UITextField!
    
    @IBOutlet weak var courname: UITextField!
    
    @IBOutlet weak var number: UITextField!
    
    @IBOutlet weak var typebtn: UIButton!
    var email: String!

    @IBOutlet weak var caseTypetbl: UITableView!
    //@IBOutlet weak var errorlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        caseTypetbl.isHidden = true
        self.number.delegate = self
          self.cname.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.cname.becomeFirstResponder()
        self.cname.text?.removeAll()
         self.courname.text?.removeAll()
         self.number.text?.removeAll()
         self.details.text?.removeAll()
        self.number.resignFirstResponder()
        
    }
    @IBAction func choosetype(_ sender: Any) {
        if caseTypetbl.isHidden{
            UIView.animate(withDuration: 0.3){
                self.caseTypetbl.isHidden = false
            }
        }
            else
            {
                UIView.animate(withDuration: 0.3){
                    self.caseTypetbl.isHidden = true
                }
            }
        

    }
    
    @IBAction func Casesubmit(_ sender: Any) {
          let error = validatefields()
                if error != nil
                {
                    self.showmessage(error!)
                }
                else
                {
                    let currentdate = Date()
                    let formatter = DateFormatter()
                  //  formatter.dateStyle = .MM/dd/yyyy
                    formatter.dateFormat = "M/d/yyyy"
                    let datestring = formatter.string(from: currentdate)
                    let name = cname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cdetails = details.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let courtname = courname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let mobile = number.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let type = ctype

                   // self.uploadprofileimage(self.profilepic.image!, em){url in
                    let ref: DatabaseReference!
                    ref = Database.database().reference()
                    let userID = Auth.auth().currentUser?.uid
                    ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                            // Get user value
                    let value = snapshot.value as? NSDictionary
                    self.email = value?["email"] as? String ?? ""
                    let cid = UUID().uuidString
                    print (cid)
                    let ldata = ["Case ID":cid,"Case Title": name, "Client Details":cdetails, "Court Name": courtname, "Case type":type, "Email": self.email, "Date of Add":datestring] as [String: Any]
                    let databaseRef = Database.database().reference()
                    databaseRef.child("LawyerCases").childByAutoId().setValue(ldata)
                     
                        
                    let lcase = self.storyboard?.instantiateViewController(withIdentifier: "LCases") as! LawyerCases
                    self.navigationController?.pushViewController(lcase, animated: true)
                    self.showmessage("The Case has added succesfully!")
                       
                    })
                    {
                        (error) in self.showmessage(error.localizedDescription)
                    }
                }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "typecase", for: indexPath)
        cell.textLabel?.text = type[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        typebtn.setTitle(type[indexPath.row], for: .normal)
        UIView.animate(withDuration: 0.3){
           self.caseTypetbl.isHidden = true
            self.ctype = self.type[indexPath.row]
        }
    }

    func validatefields() -> String? {
          
        if cname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || details.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || courname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || number.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ctype == ""
             
          {
              return "Please Fill all Fields"
          }
         return nil
    }
    
}

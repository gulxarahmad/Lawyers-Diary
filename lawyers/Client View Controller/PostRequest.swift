//
//  PostRequest.swift
//  lawyers
//
//  Created by hst on 26/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class PostRequest: UIViewController, UITableViewDataSource, UITableViewDelegate {
     var type = ["Personal Injury", "Estate Planning", "Bankruptcy", "Intellectual Property", "Employment", "Corporate", "Immigration", "Crime"]
    var ctype : String! = ""
    @IBOutlet weak var caseTitle: UITextField!
    @IBOutlet weak var caseDetail: UITextField!
    @IBOutlet weak var courtName: UITextField!
    
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var typeTbl: UITableView!
    var email: String!
    var city: String!
    var clientid: String!
    var clientname: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    typeTbl.isHidden = true

        // Do any additional setup after loading the view.
    }
    @IBAction func ChooseType(_ sender: Any) {
        if typeTbl.isHidden{
            UIView.animate(withDuration: 0.3){
                self.typeTbl.isHidden = false
            }
        }
            else
            {
                UIView.animate(withDuration: 0.3){
                    self.typeTbl.isHidden = true
                }
            }
    }
    
    

    @IBAction func AddPostClick(_ sender: Any) {
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
                           let ctitle = caseTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                           let cdetails = caseDetail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                           let courtname = courtName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                           
                           let type = ctype

                          // self.uploadprofileimage(self.profilepic.image!, em){url in
                           let ref: DatabaseReference!
                           ref = Database.database().reference()
                           let userID = Auth.auth().currentUser?.uid
                           ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                   // Get user value
                           let value = snapshot.value as? NSDictionary
                            self.clientid = value?["ID"] as? String ?? ""
                           self.email = value?["email"] as? String ?? ""
                            self.city = value?["City"] as? String ?? ""
                            self.clientname = value?["firstname"] as? String ?? ""
                           let postid = UUID().uuidString
                           print (postid)
                            let ldata = ["Client ID": self.clientid,"Client Name": self.clientname,"Post ID":postid,"Case Title": ctitle, "Details":cdetails, "Court Name": courtname, "Case type":type, "Email": self.email, "Date of Add":datestring, "City": self.city, "Status":"Pending"] as [String: Any]
                           let databaseRef = Database.database().reference()
                           databaseRef.child("Client Post Requests").childByAutoId().setValue(ldata)
                            
                               
                           self.showmessage("The Post has added succesfully!")
                              
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
        typeBtn.setTitle(type[indexPath.row], for: .normal)
        UIView.animate(withDuration: 0.3){
           self.typeTbl.isHidden = true
            self.ctype = self.type[indexPath.row]
        }
    }

    func validatefields() -> String? {
          
        if caseTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || caseDetail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || courtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ctype == ""
             
          {
              return "Please Fill all Fields"
          }
         return nil
    }

}

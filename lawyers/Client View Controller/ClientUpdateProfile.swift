//
//  ClientUpdateProfile.swift
//  lawyers
//
//  Created by hst on 25/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class ClientUpdateProfile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var genderbtn: UIButton!
    @IBOutlet weak var gendertbl: UITableView!
    @IBOutlet weak var citybtn: UIButton!
    @IBOutlet weak var citytbl: UITableView!
    
        var gend:String! = ""
            var cit:String! = ""
          var gender = ["Male", "Female"]
          var city = ["Lahore", "Karachi", "Islamabad","Quetta", "Peshawar"]
     
       var setfname: String!
       var setlname: String!
       var setemail: String!
       var setmobile: String!
       var getid: String!
    override func viewDidLoad() {
        firstname.text = setfname
              lastname.text = setlname
              email.text = setemail
              mobile.text = setmobile
            
            
        citytbl.isHidden = true
            gendertbl.isHidden = true
              genderbtn.setTitle(gend, for: .normal)
              citybtn.setTitle(cit, for: .normal)

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func UpdateClick(_ sender: Any) {
        let cities = cit
             let genders = gend
        print(getid!)
        print(email.text!)
        print(firstname.text!)
        print(lastname.text!)
        print(cities)
        print(genders)
        print(mobile.text)

             let updateprofile = ["email" : email.text, "Mobile": mobile.text, "firstname" : firstname.text,"lastname" : lastname.text, "Gender": genders!, "City": cities!] as [String: Any]
             let databaseRef = Database.database().reference()
             databaseRef.child("Client").child(getid).updateChildValues(updateprofile)
             //databaseRef.child(getid).setValue(updateprofile)
             showmessage("Your Profile Is Updated!!")
         
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
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            var num = 1
            switch tableView{
            case  gendertbl:
                 num = gender.count
            case citytbl:
                num = city.count
            default:
                print("something wrong")
            }
            return num
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var cell = UITableViewCell()
            switch tableView{
            case gendertbl:
            cell = tableView.dequeueReusableCell(withIdentifier: "gendercell", for: indexPath)
            cell.textLabel?.text = gender[indexPath.row]
            
            
            case citytbl:
            cell = tableView.dequeueReusableCell(withIdentifier: "citycell", for: indexPath)
            cell.textLabel?.text = city[indexPath.row]
            
           

                
            default:
                print("something wrong")
            }
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch tableView{
            case gendertbl:

            genderbtn.setTitle(gender[indexPath.row], for: .normal)
            self.gend = gender[indexPath.row]

            UIView.animate(withDuration: 0.3) {
                self.gendertbl.isHidden = true
            }

            case citytbl:
                citybtn.setTitle(city[indexPath.row], for: .normal)
                self.cit = city[indexPath.row]
                UIView.animate(withDuration: 0.3){
                    self.citytbl.isHidden = true
                }
     

            default:
                print("something wrong")
        }

    }
        
        @IBAction func choosegender(_ sender: Any) {
            if gendertbl.isHidden{
                UIView.animate(withDuration: 0.3){
                    self.gendertbl.isHidden = false
                }
            }
                else
                {
                    UIView.animate(withDuration: 0.3){
                        self.gendertbl.isHidden = true
                    }
                }
            self.citytbl.isHidden=true
        }
        
        @IBAction func choosecity(_ sender: Any) {
            if citytbl.isHidden{
                       UIView.animate(withDuration: 0.3){
                           self.citytbl.isHidden = false
                       }
                   }
                   else
                       {
                           UIView.animate(withDuration: 0.3){
                               self.citytbl.isHidden = true
                           }
                       }
                   self.gendertbl.isHidden=true
        }
        
}

//
//  Client Sign Up.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseAnalytics
import FirebaseDatabase
import FirebaseStorage

class Client_Sign_Up: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gend:String! = ""
    var cit:String! = ""
    var gender = ["Male", "Female"]
    var city = ["Lahore", "Karachi", "Islamabad","Quetta", "Peshawar"]
    
    @IBOutlet weak var citybtn: UIButton!
    
    @IBOutlet weak var genderbtn: UIButton!
    @IBOutlet weak var firstname: UITextField! = nil
    
    @IBOutlet weak var lasttname: UITextField! = nil
    @IBOutlet weak var email: UITextField! = nil
    @IBOutlet weak var mobile: UITextField! = nil
    
    @IBOutlet weak var password: UITextField! = nil
    
    @IBOutlet weak var cpassword: UITextField! = nil
   
   // @IBOutlet weak var errorlabel: UILabel!
    
    @IBOutlet weak var gendertbl: UITableView!
    
    @IBOutlet weak var citytbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gendertbl.isHidden=true
         citytbl.isHidden=true

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
           
        if firstname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lasttname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            mobile.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || cpassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || gend == "" || cit == ""
              
           {
               return "Please Fill all Fields"
           }
           if password.text?.trimmingCharacters(in: .whitespacesAndNewlines) != cpassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
           {
               return "Password is not match"
           }
           let passwrd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           if Utilities.isValidPassword(passwrd) == false
           {
               return "Please Enter Valid Password, Password should be 8 chracters, password must have one uppercase, one numeric and one special character"
           }
           let vemail=email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           if Utilities.isValidEmail(vemail) == false
           {
               return "Email Format is Invalid"
           }
        let vmobile=mobile.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isValidPhone(vmobile) == false
        {
            return "Phone Format is Invalid"
        }
           return nil
       }

    @IBAction func Signup(_ sender: Any) {
        
            let error = validatefields()
                if error != nil
                {
                    self.showerror(error!)
                }
                else
                {
                    let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let psw = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let fname = firstname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let lname = lasttname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let mbl = mobile.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                   let cities = cit
                    let genders = gend
  
                    
                 //   self.uploadprofileimage(self.profilepic.image!, em){url in

                    
                    
                    Auth.auth().createUser(withEmail: em, password: psw) { (result, err) in
                    let ldata = ["ID": result!.user.uid,"Mobile": mbl,"email" : em, "firstname" : fname,"lastname" : lname,"password" : psw, "User Type":"Client", "Gender":genders, "City": cities]
                    // Check for errors
                    if err != nil {
                        
                        // There was an error creating the user
                        self.showerror("the email is already registered")
                    }
                    else {

                        let databaseRef = Database.database().reference()
                        databaseRef.child("Client").child(result!.user.uid).setValue(ldata)
                        let login = self.storyboard?.instantiateViewController(withIdentifier: "CLoginVC") as! ClientLogin
                        self.navigationController?.pushViewController(login, animated: true)
               // self.transitiontoLogin()
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
        //errorlabel.text=errmessage
       // errorlabel.alpha=1
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

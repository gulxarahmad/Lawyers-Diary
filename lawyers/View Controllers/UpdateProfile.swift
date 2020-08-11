//
//  UpdateProfile.swift
//  lawyers
//
//  Created by hst on 25/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class UpdateProfile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var genderbtn: UIButton!
    @IBOutlet weak var gendertbl: UITableView!
    
    @IBOutlet weak var citytbn: UIButton!
    
    @IBOutlet weak var citytbl: UITableView!
    
    @IBOutlet weak var specialbtn: UIButton!
    @IBOutlet weak var specialtbl: UITableView!
    @IBOutlet weak var exptbl: UITableView!
    
    @IBOutlet weak var expbtn: UIButton!
    
    
    var gend:String! = ""
       var cit:String! = ""
       var spec:String! = ""
       var expert:String! = ""
       var gender = ["Male", "Female"]
       var city = ["Lahore", "Karachi", "Islamabad","Quetta", "Peshawar"]
       var special = ["Personal Injury", "Estate Planning", "Bankruptcy", "Intellectual Property", "Employment", "Corporate", "Immigration", "Crime"]
       var exp = ["1 - 3", "4 - 6", "7 - 9", "More"]

       
    var setfname: String!
    var setlname: String!
    var setemail: String!
    var setmobile: String!
    var getid: String!

    override func viewDidLoad() {
        gendertbl.isHidden=true
        citytbl.isHidden=true
        specialtbl.isHidden = true
        exptbl.isHidden=true

       
    firstname.text = setfname
        lastname.text = setlname
        email.text = setemail
        mobile.text = setmobile
        genderbtn.setTitle(gend, for: .normal)
        citytbn.setTitle(cit, for: .normal)
        specialbtn.setTitle(spec, for: .normal)
        expbtn.setTitle(expert, for: .normal)
        
 
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func UpdateClick(_ sender: Any) {
        let cities = cit
        let genders = gend
        let experts = expert
        let specs = spec
        let updateprofile = [ "email" : email.text, "Phone Number": mobile.text, "firstname" : firstname.text,"lastname" : lastname.text, "Gender": genders!, "City": cities!, "Specialization":specs, "Experience":experts] as [String: Any]
        let databaseRef = Database.database().reference()
        databaseRef.child("Lawyer").child(getid).updateChildValues(updateprofile)
        //databaseRef.child(getid).setValue(updateprofile)
        showmessage("Your Profile Is Updated!!")
         print(getid!)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 1
        switch tableView{
        case  gendertbl:
             num = gender.count
        case citytbl:
            num = city.count
        case specialtbl:
            num = special.count
        case exptbl:
            num = exp.count
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
           
            case specialtbl:
            cell = tableView.dequeueReusableCell(withIdentifier: "specializationcell", for: indexPath)
            cell.textLabel?.text = special[indexPath.row]
               
            case exptbl:
            cell = tableView.dequeueReusableCell(withIdentifier: "experiencecell", for: indexPath)
            cell.textLabel?.text = exp[indexPath.row]
                
            default:
                print("something wrong")
            }
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch tableView{
            case gendertbl:

            genderbtn.setTitle(gender[indexPath.row], for: .normal)

            UIView.animate(withDuration: 0.3) {
                self.gendertbl.isHidden = true
            }

            case citytbl:
                citytbn.setTitle(city[indexPath.row], for: .normal)
                UIView.animate(withDuration: 0.3){
                    self.citytbl.isHidden = true
                }
            case specialtbl:
                specialbtn.setTitle(special[indexPath.row], for: .normal)
                UIView.animate(withDuration: 0.3){
                    self.specialtbl.isHidden = true
                }
                case exptbl:
                    expbtn.setTitle(exp[indexPath.row], for: .normal)
                    UIView.animate(withDuration: 0.3){
                        self.exptbl.isHidden = true
                    }


            default:
                print("something wrong")
        }
            if tableView == gendertbl {
                if gender[indexPath.row] == "Male"{
                gend = gender[indexPath.row]
                print (gend!)
               // print ("Male")
            }
            else if gender[indexPath.row] == "Female"{
                gend = gender[indexPath.row]
                print (gend!)
            }
        }
            else if tableView == citytbl {
                        if city[indexPath.row] == "Lahore"{
                        cit = city[indexPath.row]
                        print (cit!)
                       // print ("Male")
                    }
                    else if city[indexPath.row] == "Karachi"{
                        cit = city[indexPath.row]
                        print (cit!)
                    }
                else if city[indexPath.row] == "Islamabad"{
                    cit = city[indexPath.row]
                    print (cit!)
                }
                else if city[indexPath.row] == "Quetta"{
                    cit = city[indexPath.row]
                    print (cit!)
                }
                else if city[indexPath.row] == "Peshawar"{
                    cit = city[indexPath.row]
                    print (cit!)
                }
            }
            else if tableView == specialtbl {
                               if special[indexPath.row] == "Personal Injury"{
                               spec = special[indexPath.row]
                               print (spec!)
                              // print ("Male")
                           }
                           else if special[indexPath.row] == "Estate Planning"{
                               spec = special[indexPath.row]
                               print (spec!)
                           }
                       else if special[indexPath.row] == "Bankruptcy"{
                           spec = special[indexPath.row]
                           print (spec!)
                       }
                               else if special [indexPath.row] == "Employment"{
                                spec = special[indexPath.row]
                                print(spec!)
                        }
                       else if special[indexPath.row] == "Intellectual Property"{
                           spec = special[indexPath.row]
                           print (spec!)
                       }
                       else if special[indexPath.row] == "Corporate"{
                           spec = special[indexPath.row]
                           print (spec!)
                       }
                        else if special[indexPath.row] == "Immigration"{
                            spec = special[indexPath.row]
                            print (spec!)
                        }
                        else if special[indexPath.row] == "Crime"{
                            spec = special[indexPath.row]
                            print (spec!)
                        }
                
                   }
            else if tableView == exptbl {
                               if exp[indexPath.row] == "1 - 3"{
                               expert = exp[indexPath.row]
                                print (expert)
                              // print ("Male")
                           }
                           else if exp[indexPath.row] == "4 - 6"{
                               expert = exp[indexPath.row]
                               print (expert)
                           }
                       else if exp[indexPath.row] == "7 - 9"{
                           expert = exp[indexPath.row]
                           print (expert)
                       }
                       else if exp[indexPath.row] == "More"{
                           expert = exp[indexPath.row]
                           print (expert)
                       }
                   }
    }
    @IBAction func selectgender(_ sender: Any) {
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
        self.exptbl.isHidden=true
        self.specialtbl.isHidden=true
        
    }
    
    
    @IBAction func selectcity(_ sender: Any) {
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
        self.exptbl.isHidden=true
        self.specialtbl.isHidden=true
    }
    

    
    @IBAction func selectspec(_ sender: Any) {
        if specialtbl.isHidden{
                 UIView.animate(withDuration: 0.3){
                     self.specialtbl.isHidden = false
                 }
             }
             else
                 {
                     UIView.animate(withDuration: 0.3){
                         self.specialtbl.isHidden = true
                     }
                 }
             self.gendertbl.isHidden=true
            self.citytbl.isHidden=true
            self.exptbl.isHidden=true
    }
    
    @IBAction func selectexp(_ sender: Any) {
        if exptbl.isHidden{
                 UIView.animate(withDuration: 0.3){
                     self.exptbl.isHidden = false
                 }
             }
             else
                 {
                     UIView.animate(withDuration: 0.3){
                         self.exptbl.isHidden = true
                     }
                 }
             self.gendertbl.isHidden=true
        self.citytbl.isHidden=true
        self.specialtbl.isHidden=true
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

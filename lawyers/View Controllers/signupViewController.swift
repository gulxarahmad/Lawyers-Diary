//
//  signupViewController.swift
//  lawyers
//
//  Created by hst on 27/02/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseAnalytics
import FirebaseDatabase
import FirebaseStorage

class signupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gend:String! = ""
    var cit:String! = ""
    var spec:String! = ""
    var expert:String = ""
    var gender = ["Male", "Female"]
    var city = ["Lahore", "Karachi", "Islamabad","Quetta", "Peshawar"]
    var special = ["Personal Injury", "Estate Planning", "Bankruptcy", "Intellectual Property", "Employment", "Corporate", "Immigration", "Crime"]
    var exp = ["1 - 3", "4 - 6", "7 - 9", "More"]
    @IBOutlet weak var firstname: UITextField! = nil
    
    @IBOutlet weak var lastname: UITextField! = nil
    
 
    @IBOutlet weak var email: UITextField! = nil
    
    @IBOutlet weak var password: UITextField! = nil
    
    @IBOutlet weak var cpassword: UITextField! = nil
    @IBOutlet weak var mobile: UITextField! = nil
    
 
    
    @IBOutlet weak var signup: UIButton!
    
    
   // @IBOutlet weak var errorlabel: UILabel!
    
    @IBOutlet weak var genderbtn: UIButton!
    
    @IBOutlet weak var gendertbl: UITableView!
    
    @IBOutlet weak var citybtn: UIButton!
    
    @IBOutlet weak var citytbl: UITableView!
    
    @IBOutlet weak var specialbtn: UIButton!
    
    @IBOutlet weak var specialtbl: UITableView!
    
    @IBOutlet weak var expbtn: UIButton!
    
    @IBOutlet weak var exptbl: UITableView!
    
    @IBOutlet weak var profilepic: UIImageView!
    

    
    @IBOutlet weak var chooseprofile: UIButton!
    var pimagepicker = UIImagePickerController()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gendertbl.isHidden=true
        citytbl.isHidden=true
        specialtbl.isHidden = true
        exptbl.isHidden=true
        // Do any additional setup after loading the view.
    }
    

    func validatefields() -> String? {
        
        if firstname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || cpassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            mobile.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            gend == "" || cit == "" || expert == "" || spec == ""
           
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
        let vnum=mobile.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isValidPhone(vnum) == false
        {
            return "Phone Number Format is Invalid"
        }
        
        return nil
    }

    @IBAction func signupclick(_ sender: Any) {
        let error = validatefields()
        if error != nil
        {
            self.showerror(error!)
        }
        else
        {
            let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let psw = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let num = mobile.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let fname = firstname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lname = lastname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let cities = cit
            let genders = gend
            let experts = expert
            let specs = spec
            
           // self.uploadprofileimage(self.profilepic.image!, em){url in
              

            
            
            Auth.auth().createUser(withEmail: em, password: psw) { (result, err) in
                let ldata = ["ID": result!.user.uid  , "email" : em, "Phone Number": num, "firstname" : fname,"lastname" : lname, "Gender": genders!, "City": cities!, "Specialization":specs, "Experience":experts, "User Type": "Lawyer"] as [String: Any]
                
            // Check for errors
            if err != nil {
                
                // There was an error creating the user
                self.showerror("the email is already registered")
            }
            else {
                

                let databaseRef = Database.database().reference()
                databaseRef.child("Lawyer").child(result!.user.uid).setValue(ldata)
                let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
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
            citybtn.setTitle(city[indexPath.row], for: .normal)
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
    @IBAction func chooseprofile(_ sender: Any) {
        self.setupprofileimage()
    }
    
}

extension signupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func setupprofileimage()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            pimagepicker.sourceType = .savedPhotosAlbum
            pimagepicker.delegate = self
            pimagepicker.isEditing = true
            self.present(pimagepicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info [UIImagePickerController.InfoKey.originalImage] as! UIImage
        profilepic.image = image
        profilepic.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
    
extension signupViewController{
    func uploadprofileimage(_ profileimg: UIImage, _ imageid: String, completion: @escaping ((_ url: URL?)->())){
        let storeimage = Storage.storage().reference().child(imageid)
        let imagedata = profilepic.image?.pngData()
        let imageMeta = StorageMetadata()
        imageMeta.contentType = "image/png"
        storeimage.putData(imagedata!, metadata:imageMeta){ (imagemeta, error) in
            if error == nil{
                print ("Success")
                storeimage.downloadURL(completion:{(url, error) in
                    completion(url!)
                    
                })
            }
            else
            {
                print("There is a problem in uploading an image")
            }
            
        }
    }
    
}

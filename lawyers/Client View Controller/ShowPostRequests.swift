//
//  ShowPostRequests.swift
//  lawyers
//
//  Created by hst on 27/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class ShowPostRequests: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ref: DatabaseReference!
    @IBOutlet weak var todaybtn: UIButton!
    @IBOutlet weak var monthbtn: UIButton!
    @IBOutlet weak var allbtn: UIButton!
    @IBOutlet weak var ShowPostTable: UITableView!
    var postsearchdata = [ShowRequestModel]()
    var email: String!
    var city: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
            self.ShowPostTable.reloadData()
            allbtn.backgroundColor = UIColor.black
            allbtn.setTitleColor(UIColor.white, for: .normal)
            monthbtn.backgroundColor = UIColor.white
            monthbtn.setTitleColor(UIColor.black, for: .normal)
            todaybtn.backgroundColor = UIColor.white
            todaybtn.setTitleColor(UIColor.black, for: .normal)
        showalldata()

        // Do any additional setup after loading the view.
    }
    
    func showalldata(){
               
               ref = Database.database().reference()
               self.postsearchdata.removeAll()
          //  self.ShowPostTable.reloadData()
            let userID = Auth.auth().currentUser?.uid

               ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
               // self.postsearchdata.removeAll()                                          // Get user value
                let value = snapshot.value as? NSDictionary
                self.email = value?["email"] as? String ?? ""
                self.ref.child("Client Post Requests").queryOrderedByKey().observeSingleEvent(of: .value){ (snapshot) in
                            
                            if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                                for snap in snapShot{
                                    let key = snap.key
                               
                                if let maindata = snap.value as? [String: AnyObject]{
                                                    
                                let ctitle = maindata["Case Title"] as? String
                                let clientname = maindata["Client Name"] as? String
                                let postid = maindata["Post ID"] as? String
                                let courtname = maindata["Court Name"] as? String
                                let city = maindata["City"] as? String
                                let casetype = maindata["Case type"] as? String
                                let det = maindata["Details"] as? String
                                let status = maindata["Status"] as? String
                               let dateadd = maindata["Date of Add"] as? String
                               let clientemail = maindata["Email"] as? String

 
                            if self.email == clientemail && status != "Complete"{
                            
                        self.postsearchdata.append(ShowRequestModel(requestkey: key, postid: postid!, casetitle: ctitle!, courtname: courtname!, casetype: casetype!, status: status!, details: det!, date: dateadd!))
                    
                                

                           }
                         
                        }
                                              
                        }
                        
                    }
                   self.ShowPostTable.reloadData()
                }
           })
    }
    func showmonthdata(){
          
            
            ref = Database.database().reference()
             self.postsearchdata.removeAll()
             let userID = Auth.auth().currentUser?.uid
             ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                             // Get user value
             let value = snapshot.value as? NSDictionary
             self.email = value?["email"] as? String ?? ""
                self.ref.child("Client Post Requests").queryOrderedByKey().observeSingleEvent(of: .value){ (snapshot) in
                       //  self.requestsearchdata.removeAll()
                         if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                             for snap in snapShot{
                                 let key = snap.key
                            
                             if let maindata = snap.value as? [String: AnyObject]{
                                                 
                             let ctitle = maindata["Case Title"] as? String
                             let clientname = maindata["Client Name"] as? String
                             let postid = maindata["Post ID"] as? String
                             let courtname = maindata["Court Name"] as? String
                             let city = maindata["City"] as? String
                             let casetype = maindata["Case type"] as? String
                             let det = maindata["Details"] as? String
                             let status = maindata["Status"] as? String
                            let dateadd = maindata["Date of Add"] as? String
                            let clientemail = maindata["Email"] as? String

                         if self.email == clientemail && status == "Pending"{
                            
                                 self.postsearchdata.append(ShowRequestModel(requestkey: key, postid: postid!, casetitle: ctitle!, courtname: courtname!, casetype: casetype!, status: status!, details: det!, date: dateadd!))
                 
                             

                        }
                      
                     }
                                           
                     }
                     
                 }
                self.ShowPostTable.reloadData()
             }
        })
     }
     func showtodaydata(){
         
         
            ref = Database.database().reference()
            self.postsearchdata.removeAll()
            let userID = Auth.auth().currentUser?.uid
            ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                            // Get user value
            let value = snapshot.value as? NSDictionary
            self.email = value?["email"] as? String ?? ""
            self.ref.child("Client Post Requests").queryOrderedByKey().observeSingleEvent(of: .value){ (snapshot) in
                  //  self.requestsearchdata.removeAll()
                    if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                        for snap in snapShot{
                            let key = snap.key
                       
                        if let maindata = snap.value as? [String: AnyObject]{
                                            
                        let ctitle = maindata["Case Title"] as? String
                        let clientname = maindata["Client Name"] as? String
                        let postid = maindata["Post ID"] as? String
                        let courtname = maindata["Court Name"] as? String
                        let city = maindata["City"] as? String
                        let casetype = maindata["Case type"] as? String
                        let det = maindata["Details"] as? String
                        let status = maindata["Status"] as? String
                       let dateadd = maindata["Date of Add"] as? String
                       let clientemail = maindata["Email"] as? String

                        
                    if self.email == clientemail && status == "Accepted"{
                       self.postsearchdata.append(ShowRequestModel(requestkey: key, postid: postid!, casetitle: ctitle!, courtname: courtname!, casetype: casetype!, status: status!, details: det!, date: dateadd!))
                       }
                     
                    }
                                          
                    }
                    
                }
                    self.ShowPostTable.reloadData()
            }
       })
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return postsearchdata.count
               
           }
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "ShowRequestData", for: indexPath) as! ShowRequestData
               cell.delegate = self
               cell.datashow = postsearchdata[indexPath.row]
               return cell
           }

           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
               return 200

       }
    @IBAction func todaycases(_ sender: Any) {
           todaybtn.backgroundColor = UIColor.black
           todaybtn.setTitleColor(UIColor.white, for: .normal)
           monthbtn.backgroundColor = UIColor.white
           monthbtn.setTitleColor(UIColor.black, for: .normal)
           allbtn.backgroundColor = UIColor.white
           allbtn.setTitleColor(UIColor.black, for: .normal)
           showtodaydata()
       }
       
       @IBAction func Monthcases(_ sender: Any) {
           monthbtn.backgroundColor = UIColor.black
           monthbtn.setTitleColor(UIColor.white, for: .normal)
           todaybtn.backgroundColor = UIColor.white
           todaybtn.setTitleColor(UIColor.black, for: .normal)
           allbtn.backgroundColor = UIColor.white
           allbtn.setTitleColor(UIColor.black, for: .normal)
           showmonthdata()
       }
       
       @IBAction func AllCases(_ sender: Any) {
           
           allbtn.backgroundColor = UIColor.black
           allbtn.setTitleColor(UIColor.white, for: .normal)
           monthbtn.backgroundColor = UIColor.white
           monthbtn.setTitleColor(UIColor.black, for: .normal)
           todaybtn.backgroundColor = UIColor.white
           todaybtn.setTitleColor(UIColor.black, for: .normal)
           showalldata()
       }
}

extension ShowPostRequests: MarkCompleteDelegate{
    func markcomplete(cell: ShowRequestData) {
        let currentdate = Date()
              let formatter = DateFormatter()
              formatter.dateFormat = "M/d/yyyy"
              let datestring = formatter.string(from: currentdate)
        let indexPath = self.ShowPostTable.indexPath(for: cell)
        let updatecase = ["Status":"Done", "Date of Done":datestring]
        let updaterequest = ["Status":"Complete"]
        
        
        ref.child("Lawyer Cases").observeSingleEvent(of: .value, with: { (snapshot)  in
                   
                   if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                       for snap in snapShot{
                           let key = snap.key
                      
                       if let maindata = snap.value as? [String: AnyObject]{
                                           
                       let postkey = maindata["Post Key"] as? String
                        if postkey == self.postsearchdata[indexPath!.row].requestkey{
                           self.ref.child("Lawyer Cases").child(key).updateChildValues(updatecase)
                           self.ref.child("Client Post Requests").child(self.postsearchdata[indexPath!.row].requestkey!).updateChildValues(updaterequest)

                        }


                      }
                                             
                       }

                       
                   }
       self.postsearchdata.remove(at: indexPath!.row)
       self.ShowPostTable.reloadData()

               })


       

        

    }
}

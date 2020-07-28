//
//  HistoryCases.swift
//  lawyers
//
//  Created by hst on 27/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class HistoryCases: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ref: DatabaseReference!
       
       @IBOutlet weak var todaybtn: UIButton!
       
       @IBOutlet weak var monthbtn: UIButton!
       
       @IBOutlet weak var allbtn: UIButton!
       
       @IBOutlet weak var CaseDataTable: UITableView!
       var email: String!
       var historysearchdata = [HistoryCaseModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CaseDataTable.reloadData()
             allbtn.backgroundColor = UIColor.black
             allbtn.setTitleColor(UIColor.white, for: .normal)
             monthbtn.backgroundColor = UIColor.white
             monthbtn.setTitleColor(UIColor.black, for: .normal)
             todaybtn.backgroundColor = UIColor.white
             todaybtn.setTitleColor(UIColor.black, for: .normal)
             showalldata()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return historysearchdata.count
           
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCaseData", for: indexPath) as! HistoryCaseData
//         cell.delegate = self
           cell.datashow = historysearchdata[indexPath.row]
           return cell
       }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 200

    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete{
        self.ref.child("Lawyer Cases").child(self.historysearchdata[indexPath.row].skey!).removeValue()
                    
                  historysearchdata.remove(at: indexPath.row)
                  CaseDataTable.deleteRows(at: [indexPath], with: .fade)
        }
    }

    

     func showalldata(){
            
            ref = Database.database().reference()
            self.historysearchdata.removeAll()
            let userID = Auth.auth().currentUser?.uid
            ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                            // Get user value
            let value = snapshot.value as? NSDictionary
            self.email = value?["email"] as? String ?? ""
                self.ref.child("Lawyer Cases").queryOrderedByKey().observe(.value){ (snapshot) in
                
                if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                    for snap in snapShot{
                        let key = snap.key
                    if let maindata = snap.value as? [String: AnyObject]{
                                        
                    let cname = maindata["Case Title"] as? String
                    let clientname = maindata["Client Name"] as? String
                    let clientid = maindata["Case ID"] as? String
                    let courtname = maindata["Court Name"] as? String
                    let casetype = maindata["Case Type"] as? String
                    let lawyeremail = maindata ["Email"] as? String
                    let det = maindata["Case Details"] as? String
                    let dateadd = maindata["Date of Done"] as? String
                    let status = maindata["Status"] as? String
                        if self.email == lawyeremail && status == "Done"{
                        self.historysearchdata.append(HistoryCaseModel(cid: clientid!, cname: cname!, courtname: courtname!, casetype: casetype!, date: dateadd!, det:det!, clientname: clientname!,skey:key))
                       }
                      
                    }
                                          
                    }
                    self.CaseDataTable.reloadData()
                }
            }
       })
    }
    
    
    func showtodaydata(){
             
              ref = Database.database().reference()
              self.historysearchdata.removeAll()
              let userID = Auth.auth().currentUser?.uid
              ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                              // Get user value
              let value = snapshot.value as? NSDictionary
              self.email = value?["email"] as? String ?? ""
                  self.ref.child("Lawyer Cases").queryOrderedByKey().observe(.value){ (snapshot) in
                  
                  if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                      for snap in snapShot{
                      let key = snap.key
                     
                      if let maindata = snap.value as? [String: AnyObject]{
                                          
                      let cname = maindata["Case Title"] as? String
                      let clientid = maindata["Case ID"] as? String
                      let clientname = maindata["Client Name"] as? String
                      let courtname = maindata["Court Name"] as? String
                      let casetype = maindata["Case Type"] as? String
                      let lawyeremail = maindata ["Email"] as? String
                      let det = maindata["Case Details"] as? String
                      let dateadd = maindata["Date of Done"] as? String
                          let status = maindata["Status"] as? String
                        let source = maindata["Source"] as? String
                          
                          
                      if self.email == lawyeremail  && status == "Done" && source == "Manual"{
                          self.historysearchdata.append(HistoryCaseModel(cid: clientid!, cname: cname!, courtname: courtname!, casetype: casetype!, date: dateadd!, det: det!, clientname: clientname!,skey:key))

                         }
                       
                      }
                                            
                      }
                      
                  }
                      self.CaseDataTable.reloadData()
              }
         })
      }
        func showmonthdata(){
        
              ref = Database.database().reference()
              self.historysearchdata.removeAll()
              let userID = Auth.auth().currentUser?.uid
              ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                              // Get user value
              let value = snapshot.value as? NSDictionary
              self.email = value?["email"] as? String ?? ""
                  self.ref.child("Lawyer Cases").queryOrderedByKey().observe(.value){ (snapshot) in
                  
                  if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                      for snap in snapShot{
                          let key = snap.key
                     
                      if let maindata = snap.value as? [String: AnyObject]{
                                          
                      let cname = maindata["Case Title"] as? String
                      let clientid = maindata["Case ID"] as? String
                       let clientname = maindata["Client Name"] as? String
                      let courtname = maindata["Court Name"] as? String
                      let casetype = maindata["Case Type"] as? String
                      let lawyeremail = maindata ["Email"] as? String
                      let det = maindata["Case Details"] as? String
                      let dateadd = maindata["Date of Done"] as? String
                    let status = maindata["Status"] as? String
                        let source = maindata["Source"] as? String
            
                          if self.email == lawyeremail && status == "Done" && source == "Request"{
                             
                                  self.historysearchdata.append(HistoryCaseModel(cid: clientid!, cname: cname!, courtname: courtname!, casetype: casetype!, date: dateadd!,  det: det!, clientname: clientname!,skey:key))
                  
                              

                         }
                       
                      }
                                            
                      }
                      
                  }
                self.CaseDataTable.reloadData()
              }
         })
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

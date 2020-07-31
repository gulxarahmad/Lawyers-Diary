//
//  LawyerCases.swift
//  lawyers
//
//  Created by hst on 03/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class LawyerCases: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ref: DatabaseReference!
    
    @IBOutlet weak var todaybtn: UIButton!
    
    @IBOutlet weak var monthbtn: UIButton!
    
    @IBOutlet weak var allbtn: UIButton!
    
    @IBOutlet weak var CaseDataTable: UITableView!
    var email: String!
    var casesearchdata = [CaseDataModel]()
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
    
    func showalldata(){
        
        ref = Database.database().reference()
        self.casesearchdata.removeAll()
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
                let caseid = maindata["Case ID"] as? String
                let clientid = maindata["Client ID"] as? String
                let courtname = maindata["Court Name"] as? String
                let casetype = maindata["Case Type"] as? String
                let lawyeremail = maindata ["Email"] as? String
                let det = maindata["Case Details"] as? String
                let dateadd = maindata["Date of Add"] as? String
                let status = maindata["Status"] as? String
                let source = maindata["Source"] as? String
                    if self.email == lawyeremail && status == "inProgress" && source == "Request"{
                        self.casesearchdata.append(CaseDataModel(cid: caseid!, cname: cname!, courtname: courtname!, casetype: casetype!, date: dateadd!, det:det!, source:source!, clientname: clientname!,skey:key, clientid: clientid!))
                   }
                  
                }
                                      
                }
                self.CaseDataTable.reloadData()
            }
        }
   })
}
      func showtodaydata(){
            let currentdate = Date()
            let formatter = DateFormatter()
               //  formatter.dateStyle = .MM/dd/yyyy
            formatter.dateFormat = "M/d/yyyy"
            let datestring = formatter.string(from: currentdate)
            ref = Database.database().reference()
            self.casesearchdata.removeAll()
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
                    let caseid = maindata["Case ID"] as? String
                    let clientid = maindata["Client ID"] as? String
                    let clientname = maindata["Client Name"] as? String
                    let courtname = maindata["Court Name"] as? String
                    let casetype = maindata["Case Type"] as? String
                    let lawyeremail = maindata ["Email"] as? String
                    let det = maindata["Case Details"] as? String
                    let dateadd = maindata["Date of Add"] as? String
                    let status = maindata["Status"] as? String
                        let source = maindata["Source"] as? String
                        
                     print(datestring)
                     print(dateadd!)
                        
                    if self.email == lawyeremail && datestring == dateadd && status == "inProgress" && source == "Request"{
                        self.casesearchdata.append(CaseDataModel(cid: caseid!, cname: cname!, courtname: courtname!, casetype: casetype!, date: dateadd!, det: det!,source:source!, clientname: clientname!,skey:key, clientid: clientid!))

                       }
                     
                    }
                                          
                    }
                    
                }
                    self.CaseDataTable.reloadData()
            }
       })
    }
      func showmonthdata(){
            let currentdate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "M"
            let datestring = formatter.string(from: currentdate) // yahan live month ko string mein convert ho rha
            let monthofdate = formatter.date(from:datestring) // yahan live month ko string sy date mein convert ho rha
            let todayint:Int? = Int(datestring) // live month ko int mein convert kiya
            let lastmonth:Int! = (todayint!-1) // live month ko ek month pichy convert kiya hai
            let lastmonthdate:String! = String(lastmonth) // previous month ko string mein convert kiya
            let stringtodate = formatter.date(from:lastmonthdate) // previous month ko stirng sy date mein convert kiya
            formatter.dateFormat = "d"
            let currentdaystr = formatter.string(from: currentdate)
            print(currentdaystr)
            let currentday = formatter.date(from: currentdaystr)
            ref = Database.database().reference()
            self.casesearchdata.removeAll()
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
                    let caseid = maindata["Case ID"] as? String
                    let clientid = maindata["Client ID"] as? String
                     let clientname = maindata["Client Name"] as? String
                    let courtname = maindata["Court Name"] as? String
                    let casetype = maindata["Case Type"] as? String
                    let lawyeremail = maindata ["Email"] as? String
                    let det = maindata["Case Details"] as? String
                    let dateadd = maindata["Date of Add"] as? String
                        let status = maindata["Status"] as? String
                        let source = maindata["Source"] as? String
                    let formatter = DateFormatter()
                    formatter.dateFormat = "M/d/yyyy"
                    let stodate = formatter.date(from: dateadd!)
                    formatter.dateFormat = "M"
                    let fetchdate = formatter.string(from: stodate!)
                       print("these are recorded monthes" + fetchdate)
                    let fetchrecorddate = formatter.date(from: fetchdate)
                        formatter.dateFormat = "d"
                        let fetchday = formatter.string(from: stodate!)
                        print("These are recorded days" + fetchday)
                        let fetchrecordday = formatter.date(from: fetchday)
                    //    print(fetchdate)
                 //   let fetchdatetoint: Int? = Int(fetchdate)
                  //  print(fetchdatetoint)
                        if self.email == lawyeremail && status == "inProgress" && source == "Request"{
                            if (fetchrecorddate?.compare(monthofdate!) == .orderedSame && ( fetchrecordday?.compare(currentday!) == .orderedAscending || fetchrecordday?.compare(currentday!) == .orderedSame)) || (fetchrecorddate?.compare(stringtodate!) == .orderedSame && fetchrecordday?.compare(currentday!) == .orderedDescending) {
                                self.casesearchdata.append(CaseDataModel(cid: caseid!, cname: cname!, courtname: courtname!, casetype: casetype!, date: dateadd!,  det: det!,source:source!, clientname: clientname!,skey:key, clientid: clientid!))
                
                            }

                       }
                     
                    }
                                          
                    }
                    
                }
               self.CaseDataTable.reloadData()
            }
       })
    }
    
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casesearchdata.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseData", for: indexPath) as! CaseData
        cell.delegate = self
        cell.datashow = casesearchdata[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:ShowCaseData = self.storyboard?.instantiateViewController(withIdentifier: "CaseDetails") as! ShowCaseData
        self.navigationController?.pushViewController(detail, animated:true)
        
        detail.client = casesearchdata[indexPath.row].cname!
        detail.contact = casesearchdata[indexPath.row].clientname
        detail.CaseID = casesearchdata[indexPath.row].cid!
        detail.det = casesearchdata[indexPath.row].details!
        detail.court = casesearchdata[indexPath.row].courtname!
        detail.type = casesearchdata[indexPath.row].casetype!
        
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
extension LawyerCases: ShowCaseDelegate{
    func markcasedone(cell: CaseData) {

        
        let currentdate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        let datestring = formatter.string(from: currentdate)
        let indexPath = self.CaseDataTable.indexPath(for: cell)
        let updates = ["Status":"Done",
                       "Date of Done":datestring
        ]
        ref.child("Lawyer Cases").child(casesearchdata[indexPath!.row].skey!).updateChildValues(updates)
       
      //  self.casesearchdata.remove(at: indexPath!.row)
        self.casesearchdata.removeAll()
        self.CaseDataTable.reloadData()
        

    }
}

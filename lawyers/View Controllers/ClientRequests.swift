//
//  ClientRequests.swift
//  lawyers
//
//  Created by hst on 26/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase
class ClientRequests: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ref: DatabaseReference!
    @IBOutlet weak var todaybtn: UIButton!
    @IBOutlet weak var monthbtn: UIButton!
    @IBOutlet weak var allbtn: UIButton!
    
    @IBOutlet weak var RequestDataTable: UITableView!
    var requestsearchdata = [RequestDataModel]()
    var email: String!
    var city: String!
    var lawyerid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.RequestDataTable.reloadData()
/*        allbtn.backgroundColor = UIColor.black
        allbtn.setTitleColor(UIColor.white, for: .normal)
        monthbtn.backgroundColor = UIColor.white
        monthbtn.setTitleColor(UIColor.black, for: .normal)
        todaybtn.backgroundColor = UIColor.white
        todaybtn.setTitleColor(UIColor.black, for: .normal)*/
        showalldata()
        // Do any additional setup after loading the view.
    }
    

    func showalldata(){
            
            ref = Database.database().reference()
            self.requestsearchdata.removeAll()
       // self.RequestDataTable.reloadData()

        ref.child("Client Post Requests").queryOrderedByKey().observeSingleEvent(of: .value){ (snapshot) in
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
                     let date = maindata["Date of Add"] as? String
                     let clientid = maindata["Client ID"] as? String
                        
                        if status == "Pending"{
                            self.requestsearchdata.append(RequestDataModel(requestkey: key, postid: postid!, casetitle: ctitle!, courtname: courtname!, casetype: casetype!, city: city!, details: det!, date: date!,clientname:clientname!, clientid: clientid!))
 
                      
                        }
                    }
                                          
                    }
                }
                    self.RequestDataTable.reloadData()
            }
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return requestsearchdata.count
            
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestData", for: indexPath) as! RequestData
            cell.delegate = self
            cell.datashow = requestsearchdata[indexPath.row]
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 200

    }
}
//MARK:- ACCEPT CASE REQUEST DELEAGATE METHODS.

extension ClientRequests : RequestDataDelegate{
    func acceptCaseRequest(cell: RequestData) {
        let indexPath = self.RequestDataTable.indexPath(for: cell)
        
       let currentdate = Date()
    let formatter = DateFormatter()
                     //  formatter.dateStyle = .MM/dd/yyyy
        formatter.dateFormat = "M/d/yyyy"
    let datestring = formatter.string(from: currentdate)
      let userID = Auth.auth().currentUser?.uid
    ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                               // Get user value
    let value = snapshot.value as? NSDictionary
    self.email = value?["email"] as? String ?? ""
    self.lawyerid = value?["ID"] as? String ?? ""

        let cid = UUID().uuidString
        print (cid)
        let casedata = [
            "Post Key": self.requestsearchdata[indexPath!.row].requestkey,
            "Case Title": self.requestsearchdata[indexPath!.row].casetitle,
            "Case Details": self.requestsearchdata[indexPath!.row].details,
            "Date of Add":datestring,
            "Date of Done": "nil",
            "Case Type" : self.requestsearchdata [indexPath!.row].casetype,
           "Case ID": cid,
           "Source":"Request",
           "Status":"inProgress",
           "Court Name": self.requestsearchdata [indexPath!.row].courtname,
            "Email": self.email,
            "Lawyer ID": self.lawyerid,
            "Client ID" : self.requestsearchdata[indexPath!.row].clientid,
            "Client Name": self.requestsearchdata[indexPath!.row].clientname
        ]
        print(self.lawyerid!)
        let status = ["Status":"Accepted", "Lawyer ID":self.lawyerid]
        
        self.ref.child("Client Post Requests").child(self.requestsearchdata[indexPath!.row].requestkey!).updateChildValues(status)
        self.ref.child("Lawyer Cases").childByAutoId().setValue(casedata)
        self.requestsearchdata.remove(at: indexPath!.row)
        self.RequestDataTable.reloadData()
      //  ref.child("Client Post Requests").child(self.requestsearchdata[IndexPath,row].requestkey!)
    })

        

 }
}

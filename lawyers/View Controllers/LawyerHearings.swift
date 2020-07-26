//
//  LawyerHearings.swift
//  lawyers
//
//  Created by hst on 12/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class LawyerHearings: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var HearingDataTable: UITableView!
    

    var email:String!
    var hearingsearchdata = [HearingDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.HearingDataTable.reloadData()

        showalldata()
        // Do any additional setup after loading the view.
    }
    
    
        func showalldata(){
            let ref: DatabaseReference!
            ref = Database.database().reference()
            self.hearingsearchdata.removeAll()
            let userID = Auth.auth().currentUser?.uid
            ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                            // Get user value
            let value = snapshot.value as? NSDictionary
            self.email = value?["email"] as? String ?? ""
                ref.child("Hearings").queryOrderedByKey().observe(.value){ (snapshot) in
                
                if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                    for snap in snapShot{
                        let key = snap.key
                   
                    if let maindata = snap.value as? [String: AnyObject]{
                                        
                    let cname = maindata["Client Title"] as? String
                    let hearingdate = maindata["Hearing Date"] as? String
                    let agenda = maindata["Agenda"] as? String
                    let lawyeremail = maindata ["Email"] as? String
                    let hearid = maindata["Hearing ID"] as? String
                    let nformatter = DateFormatter()
                    nformatter.dateFormat = "MMM, dd, YYYY h:mm a"
                    let stodate = nformatter.date(from: hearingdate!)
                        nformatter.dateFormat = "MMM, dd, YYYY"
                    let heardate = nformatter.string(from: stodate!)
                        print(heardate)
                    nformatter.dateFormat = "h:mm a"
                    let heartime = nformatter.string(from: stodate!)
                      print(heartime)

                    if self.email == lawyeremail{

                        self.hearingsearchdata.append(HearingDataModel(skey:key, hearingid: hearid!, cname: cname!,  hearingtime: heartime, hearingagenda: agenda! ))
                       }
                      self.HearingDataTable.reloadData()
                    }
                                          
                    }
                }
            }
       })
    }
    
     
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return hearingsearchdata.count
            
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HearingData", for: indexPath) as! HearingData
            cell.datashow = hearingsearchdata[indexPath.row]
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 150

    }
    
    
    


}

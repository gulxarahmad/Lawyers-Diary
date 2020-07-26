//
//  ShowCaseData.swift
//  lawyers
//
//  Created by hst on 23/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase
class ShowCaseData: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var HearingDataTable: UITableView!
    
    @IBOutlet weak var clientname: UILabel!
    
    @IBOutlet weak var details: UILabel!
    
    @IBOutlet weak var courtname: UILabel!
    
    @IBOutlet weak var contactnumber: UILabel!
    
    @IBOutlet weak var casetype: UILabel!
    
    var client:String!
    var CaseID: String!
    var det:String!
    var court:String!
    var contact:String!
    var type:String!
    var email:String!
    var hearingsearchdata = [HearingDataModel]()
    var keysArray = [String]()
    var ref: DatabaseReference!
    override func viewDidLoad() {
        clientname.text = client
        details.text = det
        courtname.text = court
        contactnumber.text = contact
        casetype.text = type
        clientname.sizeToFit()
        details.sizeToFit()
        courtname.sizeToFit()
        casetype.sizeToFit()
        contactnumber.sizeToFit()
        details.numberOfLines = 0
        showalldata()
        print (CaseID)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showalldata(){
               
               ref = Database.database().reference()
               self.hearingsearchdata.removeAll()
               let userID = Auth.auth().currentUser?.uid
               ref.child("Lawyer").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                               // Get user value
               let value = snapshot.value as? NSDictionary
               self.email = value?["email"] as? String ?? ""
                self.ref.child("Hearings").queryOrderedByKey().observe(.value){ (snapshot) in
                   
                   if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                       for snap in snapShot{
                        let key = snap.key
                       if let maindata = snap.value as? [String: AnyObject]{
                                           
                       let cname = maindata["Case Title"] as? String
                       let hearingdate = maindata["Hearing Date"] as? String
                       let agenda = maindata["Agenda"] as? String
                       let lawyeremail = maindata ["Email"] as? String
                       let clientid = maindata["Case ID"] as? String
                       let hearingid = maindata["Hearing ID"] as? String
                       let nformatter = DateFormatter()
                       nformatter.dateFormat = "MMM, dd, YYYY h:mm a"
                       let stodate = nformatter.date(from: hearingdate!)
                           nformatter.dateFormat = "MMM, dd, YYYY"
                       let heardate = nformatter.string(from: stodate!)
                           print(heardate)
                       nformatter.dateFormat = "h:mm a"
                       let heartime = nformatter.string(from: stodate!)
                         print(heartime)

                        if self.email == lawyeremail && self.CaseID == clientid{
                        self.hearingsearchdata.append(HearingDataModel(skey: key, hearingid: hearingid! ,cname: cname!, hearingtime: heartime, hearingagenda: agenda!))
                          }
                         self.HearingDataTable.reloadData()
                       }
                                             
                       }
                   }
               }
          })
       }
    
    @IBAction func addtohearing(_ sender: Any) {
        let addhearing:LawyerAddHearing = self.storyboard?.instantiateViewController(withIdentifier: "LAddHearing") as! LawyerAddHearing
    self.navigationController?.pushViewController(addhearing, animated:true)
        addhearing.setcname = client
        addhearing.CaseID = CaseID
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
 
      
            self.ref.child("Hearings").child(self.hearingsearchdata[indexPath.row].skey!).removeValue()
         
        hearingsearchdata.remove(at: indexPath.row)
        HearingDataTable.deleteRows(at: [indexPath], with: .fade)
        }

    }
   
}

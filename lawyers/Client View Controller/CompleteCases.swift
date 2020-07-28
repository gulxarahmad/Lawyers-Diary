//
//  CompleteCases.swift
//  lawyers
//
//  Created by hst on 28/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Firebase

class CompleteCases: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var ref: DatabaseReference!
    @IBOutlet weak var todaybtn: UIButton!
    
    @IBOutlet weak var monthbtn: UIButton!
    
    @IBOutlet weak var allbtn: UIButton!
    
    @IBOutlet weak var CompleteCaseTable: UITableView!
    var email: String!
    var completesearchdata = [CompleteCasesModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        showalldata()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return completesearchdata.count
             
         }
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteCasesData", for: indexPath) as! CompleteCasesData
          // cell.delegate = self
             cell.datashow = completesearchdata[indexPath.row]
             return cell
         }
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          
              return 200

      }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
        self.ref.child("Client Post Requests").child(self.completesearchdata[indexPath.row].skey!).removeValue()
                    
                  completesearchdata.remove(at: indexPath.row)
                    CompleteCaseTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func showalldata(){
               
               ref = Database.database().reference()
               self.completesearchdata.removeAll()
               let userID = Auth.auth().currentUser?.uid
               ref.child("Client").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                                                               // Get user value
               let value = snapshot.value as? NSDictionary
               self.email = value?["email"] as? String ?? ""
                   self.ref.child("Client Post Requests").queryOrderedByKey().observe(.value){ (snapshot) in
                   
                   if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                       for snap in snapShot{
                           let key = snap.key
                       if let maindata = snap.value as? [String: AnyObject]{
                                           
                       let cname = maindata["Case Title"] as? String
                       let courtname = maindata["Court Name"] as? String
                       let casetype = maindata["Case type"] as? String
                       let clientemail = maindata ["Email"] as? String
                       let status = maindata["Status"] as? String
                           if self.email == clientemail && status == "Complete"{
                           self.completesearchdata.append(CompleteCasesModel(cname: cname!, courtname: courtname!, casetype: casetype!, status: status!,skey:key))
                          }
                         
                       }
                                             
                       }
                       self.CompleteCaseTable.reloadData()
                   }
               }
          })
       }
    

}

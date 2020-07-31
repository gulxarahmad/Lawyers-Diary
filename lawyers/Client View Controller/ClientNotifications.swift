//
//  ClientNotifications.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class ClientNotifications: UIViewController {


        var models = [clientreminder]()
           
           @IBOutlet var table:UITableView!


        override func viewDidLoad() {
            super.viewDidLoad()
            
      
            
            table.delegate = self
            table.dataSource = self
        }
        

        
    @available(iOS 13.0, *)
    @IBAction func didTapAdd(){
            
            // show add vc
            guard let vc = storyboard?.instantiateViewController(identifier: "added") as? AddNewClientController else {
                return
                
            }
            vc.title = "New Reminder"
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.completion = {title,body,date in
                DispatchQueue.main.async{
                    self.navigationController?.popViewController(animated: true)
        
                    let old = clientreminder(title: title, date: date, identifier: "id_\(title)")
                    self.models.append(old)
                    self.table.reloadData()
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.sound = .default
                    content.body = body
                    
                    let targetDate = date
                    let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: targetDate), repeats: false)
                    
                     
                    
                    let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: {Error in
                        if Error != nil{
                            print("Something went Wrong")
                }
                    })
                    }
            }
                
            navigationController?.pushViewController(vc, animated: true)
        }
        @IBAction func didTapTest(){
           
            // fire test notification
            navigationController?.popToViewController(ofClass: Client_Home.self)
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: {success,Error in
               if success{
                   // print ("success test")
               // self.scheduleTest()
                 }
               else if Error != nil {
                    
                    print("error occured")
                
                }
                
            })
          
        }

       /* func scheduleTest(){
            
            let content = UNMutableNotificationContent()
            content.title = "Hello World"
            content.sound = .default
            content.body = "My Long Body.My Long Body.My Long Body.My Long Body."
            
            let targetDate = Date().addingTimeInterval(10)
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: targetDate), repeats: false)
            
            let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: {Error in
                if Error != nil{
                    print("Something went Wrong")
                }
            })
            
        }*/

    }

    extension ClientNotifications:UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }

    extension ClientNotifications:UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return models.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            cell.textLabel?.text = models[indexPath.row].title
            let date = models[indexPath.row].date
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM, dd, YYYY at hh:mm "
            
            cell.detailTextLabel?.text = formatter.string(from: date)
            return cell
        }
        
    }

    struct clientreminder {
        let title: String
        let date: Date
        let identifier: String
    }

   /* extension UINavigationController {
      func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
          popToViewController(vc, animated: animated)
        }
      }
    }

     */


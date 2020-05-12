//
//  ClientFAQs.swift
//  lawyers
//
//  Created by hst on 11/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class ClientFAQs: UIViewController {
    

    @IBOutlet weak var ans1: UILabel!
    
    @IBOutlet weak var ans2: UILabel!
    
    @IBOutlet weak var ans3: UILabel!
    
    @IBOutlet weak var ans4: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ans1.isHidden = true
        ans2.isHidden = true
        ans3.isHidden = true
        ans4.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ques1(_ sender: Any) {
        if ans1.isHidden{
                   UIView.animate(withDuration: 0.3){
                       self.ans1.isHidden = false
                   }
               }
                   else
                   {
                       UIView.animate(withDuration: 0.3){
                           self.ans1.isHidden = true
                       }
                   }
               self.ans2.isHidden=true
               self.ans3.isHidden=true
               self.ans4.isHidden=true
    }
    @IBAction func ques2(_ sender: Any) {
        if ans2.isHidden{
                   UIView.animate(withDuration: 0.3){
                       self.ans2.isHidden = false
                   }
               }
                   else
                   {
                       UIView.animate(withDuration: 0.3){
                           self.ans2.isHidden = true
                       }
                   }
               self.ans1.isHidden=true
               self.ans3.isHidden=true
               self.ans4.isHidden=true
    }
    
    @IBAction func ques3(_ sender: Any) {
    if ans3.isHidden{
            UIView.animate(withDuration: 0.3){
                self.ans3.isHidden = false
            }
        }
            else
            {
                UIView.animate(withDuration: 0.3){
                    self.ans3.isHidden = true
                }
            }
        self.ans1.isHidden=true
        self.ans2.isHidden=true
        self.ans4.isHidden=true
    }
    
    @IBAction func ques4(_ sender: Any) {
    if ans4.isHidden{
            UIView.animate(withDuration: 0.3){
                self.ans4.isHidden = false
            }
        }
            else
            {
                UIView.animate(withDuration: 0.3){
                    self.ans4.isHidden = true
                }
            }
        self.ans2.isHidden=true
        self.ans3.isHidden=true
        self.ans1.isHidden=true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

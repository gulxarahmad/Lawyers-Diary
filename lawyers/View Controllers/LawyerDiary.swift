//
//  LawyerDiary.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit

class LawyerDiary: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func GoAddmycases(_ sender: Any) {
        let cases = self.storyboard?.instantiateViewController(withIdentifier: "LCases") as! LawyerCases
        self.navigationController?.pushViewController(cases, animated: true)
    }
    @IBAction func GoAddmyHearings(_ sender: Any) {
        let hearing = self.storyboard?.instantiateViewController(withIdentifier: "LHearings") as! LawyerHearings
        self.navigationController?.pushViewController(hearing, animated: true)
    }
    
}

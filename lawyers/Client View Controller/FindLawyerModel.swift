
//
//  FindLawyerModel.swift
//  lawyers
//
//  Created by hst on 04/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//
import UIKit
import Foundation
class FindLawyerModel{
    var fname: String?
    var lname: String?
    var spec: String?
    var city: String?
    var lawyerid: String?
    init (fname: String, lname: String, spec: String, city: String, lawyerid: String){
        self.fname = fname
        self.lname = lname
        self.spec = spec
        self.city = city
        self.lawyerid = lawyerid
    }
    
}

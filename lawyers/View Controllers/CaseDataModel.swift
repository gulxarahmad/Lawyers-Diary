//
//  CaseDataModel.swift
//  lawyers
//
//  Created by hst on 08/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Foundation
class CaseDataModel{
    var cname: String?
    var courtname: String?
    var casetype: String?
    var mobile: String?
    init (cname: String, courtname: String, casetype: String, mobile: String){
        self.cname = cname
        self.courtname = courtname
        self.casetype = casetype
        self.mobile = mobile
    }
}

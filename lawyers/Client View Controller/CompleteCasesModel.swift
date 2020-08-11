
//
//  CaseDataModel.swift
//  lawyers
//
//  Created by hst on 08/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Foundation
class  CompleteCasesModel{
    var cname: String?
    var status: String?
    var courtname: String?
    var casetype: String?
    var skey:String?
    init (cname: String, courtname: String, casetype: String, status: String,skey:String){
        self.cname = cname

        self.courtname = courtname
        self.casetype = casetype

        self.status = status
        self.skey = skey
    }
}

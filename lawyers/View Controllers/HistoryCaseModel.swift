//
//  CaseDataModel.swift
//  lawyers
//
//  Created by hst on 08/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import Foundation
class HistoryCaseModel{
    var cname: String?
    var clientname: String?
    var cid: String?
    var courtname: String?
    var casetype: String?
    var date: String?
    var details:String?
    var skey:String?
    init (cid: String, cname: String, courtname: String, casetype: String, date: String, det: String, clientname: String,skey:String){
        self.cname = cname
        self.cid = cid
        self.courtname = courtname
        self.casetype = casetype
        self.date = date
        self.details = det
        self.clientname = clientname
        self.skey = skey
    }
}

//
//  ShowRequestModel.swift
//  lawyers
//
//  Created by hst on 27/07/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import Foundation
import UIKit
import Foundation
class ShowRequestModel{
    var casetitle: String?
    var requestkey:String?
    var postid: String?
    var courtname: String?
    var casetype: String?
    var status: String?
    var details:String?
    var date: String?
    var lawyerid: String?
    init (requestkey:String, postid: String, casetitle: String, courtname: String, casetype: String, status: String, details: String, date: String, lawyerid: String){
        self.casetitle = casetitle
        self.requestkey = requestkey
        self.postid = postid
        self.courtname = courtname
        self.casetype = casetype
        self.status = status
        self.details = details
        self.date = date
        self.lawyerid = lawyerid
    }
}

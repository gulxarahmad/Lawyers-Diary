//
//  HearingDataModel.swift
//  lawyers
//
//  Created by hst on 12/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import Foundation
import UIKit
class HearingDataModel{
    var cname: String?
    var hearingtime: String?
    var hearingdate: String?
    init (cname: String, hearingtime: String, hearingdate: String){
        self.cname = cname
        self.hearingtime = hearingtime
        self.hearingdate = hearingdate
    }
}


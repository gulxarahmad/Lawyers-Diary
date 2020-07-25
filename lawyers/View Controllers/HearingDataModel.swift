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
    var skey:String?
    var hearingid: String?
    var cname: String?
<<<<<<< HEAD
    var hearingdate: String?

    init (cname: String,  hearingdate: String){

=======
    var hearingtime: String?
    var hearingagenda: String?
    init (skey: String, hearingid: String, cname: String,  hearingtime: String, hearingagenda: String){
        self.skey = skey
        self.hearingid = hearingid
>>>>>>> dev-Gulzar
        self.cname = cname
        self.hearingtime = hearingtime
        self.hearingagenda = hearingagenda
    }
}



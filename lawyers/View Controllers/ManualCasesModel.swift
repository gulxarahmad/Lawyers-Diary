import UIKit
import Foundation
class ManualCasesModel{
    var cname: String?
    var clientname: String?
    var cid: String?
    var courtname: String?
    var casetype: String?
    var date: String?
    var details:String?
    var source:String?
    var skey:String?
    init (cid: String, cname: String, courtname: String, casetype: String, date: String, det: String,source:String, clientname: String,skey:String){
        self.cname = cname
        self.cid = cid
        self.courtname = courtname
        self.casetype = casetype
        self.date = date
        self.details = det
        self.clientname = clientname
        self.skey = skey
        self.source = source
    }
}

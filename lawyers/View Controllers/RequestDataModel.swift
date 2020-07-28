import UIKit
import Foundation
class RequestDataModel{
    var casetitle: String?
    var requestkey:String?
    var postid: String?
    var courtname: String?
    var casetype: String?
    var city: String?
    var details:String?
    var date: String?
    var clientname: String?
    init (requestkey:String, postid: String, casetitle: String, courtname: String, casetype: String, city: String, details: String, date: String, clientname: String){
        self.casetitle = casetitle
        self.requestkey = requestkey
        self.postid = postid
        self.courtname = courtname
        self.casetype = casetype
        self.city = city
        self.details = details
        self.date = date
        self.clientname = clientname
    }
}

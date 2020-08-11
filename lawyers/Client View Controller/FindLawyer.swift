import UIKit
import Firebase

class FindLawyer: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var citybtn: UIButton!
    
    @IBOutlet weak var typebtn: UIButton!
    
    @IBOutlet weak var TypeTable: UITableView!
    
    @IBOutlet weak var CityTable: UITableView!
    @IBOutlet weak var LawyerDataTable: UITableView!
    var city = ""
    var types = ""
    var spectype = ["Personal Injury", "Estate Planning", "Bankruptcy", "Intellectual Property", "Employment", "Corporate", "Immigration", "Crime"]
    var citytype = ["Lahore", "Karachi", "Islamabad","Quetta", "Peshawar"]
    
    
    var searchdata = [FindLawyerModel]()


    override func viewDidLoad() {
        TypeTable.isHidden = true
        CityTable.isHidden = true
        super.viewDidLoad()

       

        // Do any additional setup after loading the view.
    }

    func showdata(){
        var type = ""
        var cities = ""
         self.searchdata.removeAll()
        type = self.types
        cities = self.city
        let ref: DatabaseReference!
        
         ref = Database.database().reference()
        ref.child("Lawyer").queryOrderedByKey().observe(.value){ (snapshot) in
           if let snapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapShot{
                    if let maindata = snap.value as? [String: AnyObject]{
                      
                        let fname = maindata["firstname"] as? String
                        let lname = maindata["lastname"] as? String
                       let spec = maindata["Specialization"] as? String
                        let city = maindata["City"] as? String
                        let lawyerid = maindata["ID"] as? String
                        
                        if spec == type && city == cities{
                            self.searchdata.append(FindLawyerModel(fname: fname!, lname: lname!, spec: spec!, city:city!, lawyerid:lawyerid!))
                       
                       print(fname!)
                       print(spec!)
                       print(lname!)
                       print(city!)
                       
                        }
                       self.LawyerDataTable.reloadData()
                        
                    }
                }
            }
            
        }
    }
    
    
    @IBAction func choosetype(_ sender: Any) {
        if TypeTable.isHidden{
                 UIView.animate(withDuration: 0.3){
                     self.TypeTable.isHidden = false
                 }
             }
             else
                 {
                     UIView.animate(withDuration: 0.3){
                         self.TypeTable.isHidden = true
                     }
                 }
     
            self.CityTable.isHidden=true


    }
    
    
    @IBAction func choosecity(_ sender: Any) {
        if CityTable.isHidden{
                 UIView.animate(withDuration: 0.3){
                     self.CityTable.isHidden = false
                 }
             }
             else
                 {
                     UIView.animate(withDuration: 0.3){
                         self.CityTable.isHidden = true
                     }
                 }
             self.TypeTable.isHidden=true


    }
    
    @IBAction func searchbtn(_ sender: Any) {
         showdata()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 1
        switch tableView{
        case  LawyerDataTable:
             num = searchdata.count
        case TypeTable:
            num = spectype.count
        case CityTable:
            num = citytype.count
 
        default:
            print("something wrong")
        }
        return num
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell = UITableViewCell()
              switch tableView{
              case TypeTable:
              cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
              cell.textLabel?.text = spectype[indexPath.row]
              
              case CityTable:
              cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
              cell.textLabel?.text = citytype[indexPath.row]
              case LawyerDataTable:
                 let data = tableView.dequeueReusableCell(withIdentifier: "LawyerData", for: indexPath) as! LawyerData
                    let details = searchdata[indexPath.row]
                    data.fname?.text = details.fname
                    data.lname?.text = details.lname
                    data.spec?.text = details.spec
                    data.city?.text = details.city
                    data.delegate = self
                    return data
              default:
                print("Something Wrong")
        }
                
                return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView{
        case TypeTable:

        typebtn.setTitle(spectype[indexPath.row], for: .normal)
        self.types = self.spectype[indexPath.row]
        print (types)
        UIView.animate(withDuration: 0.3) {
            self.TypeTable.isHidden = true
        }

        case CityTable:
            citybtn.setTitle(citytype[indexPath.row], for: .normal)
            self.city = self.citytype[indexPath.row]
            print (city)
            UIView.animate(withDuration: 0.3){
                self.CityTable.isHidden = true
                
            }


        default:
            print("something wrong")
    }
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Swift 4.2 onwards
        switch tableView{
        case TypeTable:
            return 50
        case CityTable:
            return 50
        default:
            return 200
        }


    }
    
}

extension FindLawyer:sendRequestDelegate{
    func sendrequest(cell: LawyerData) {
        let indexPath = self.LawyerDataTable.indexPath(for: cell)
        let request = self.storyboard?.instantiateViewController(withIdentifier: "ClientPostRequest") as! PostRequest
            request.lawyerid = searchdata[indexPath!.row].lawyerid
                self.navigationController?.pushViewController(request, animated: true)
    }
}

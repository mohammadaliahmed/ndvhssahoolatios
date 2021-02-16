//
//  HomeViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topHeader: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var topName: UILabel!
    var tickets=[Ticket]()
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
        getDataFromServer{
            self.tableView.reloadData()
        }
        tableView.delegate=self
        tableView.dataSource=self
        
        topHeader.layer.cornerRadius=10
        
        
        
        let defaults = UserDefaults.standard
        topName.text = defaults.string(forKey: "name")
        email.text = defaults.string(forKey: "email")
        phone.text = defaults.string(forKey: "phone")
        address.text = "House #" + (defaults.string(forKey: "housenumber") ?? "") + ", " + (defaults.string(forKey: "block") ?? "")
        var myValue = defaults.string(forKey: "avatar")
        
        if(myValue != nil){
            var imgUrl="http://sahoolat.ndvhs.com/uploads/"+myValue!
            if let url = URL(string: imgUrl) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }

                    DispatchQueue.main.async { /// execute on main thread
                        self.imageView.image = UIImage(data: data)
                        self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
                        self.imageView.clipsToBounds = true
                    }
                }

                task.resume()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //            let cell = UITableViewCell(style:.default,reuseIdentifier: nil)
        //            cell.textLabel?.text=tickets[indexPath.row].subject
        let cell=tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCellController
        
        cell.subj.text=tickets[indexPath.row].subject!
        cell.desc.text=tickets[indexPath.row].description!
        var ticket=tickets[indexPath.row]
        
        cell.cellView.layer.cornerRadius = 5
        cell.cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.cellView.layer.shadowRadius = 2
        cell.cellView.layer.shadowOpacity = 0.3
        
        
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowPath = UIBezierPath(roundedRect: cell.cellView.bounds,
                                                      byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 2, height:
                                                                                                            8)).cgPath
        cell.cellView.layer.shouldRasterize = true
        cell.cellView.layer.rasterizationScale = UIScreen.main.scale
        
        
        if (ticket.status=="closed") {
            cell.ticketStatusView.backgroundColor=UIColor.green
        }else if(ticket.status=="resolved"){
            cell.ticketStatusView.backgroundColor=UIColor.orange
        }
        else if(ticket.status=="pending"){
            cell.ticketStatusView.backgroundColor=UIColor.blue
        }else if(ticket.status=="processing"){
            cell.ticketStatusView.backgroundColor=UIColor.purple
        }else{
            cell.ticketStatusView.backgroundColor=UIColor.red
        }
        
        
        return cell;
        
        
    }
    func getDataFromServer(comlete: @escaping()->()){
        let defaults = UserDefaults.standard
        let myValue = defaults.integer(forKey: "userid")
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",phone: "", password: "",id: myValue)
        
        
        
        let apiRequest=APIRequest(endpoint: "ticket/allTickets")
        apiRequest.hometickets(postRequest: postRequest, completion: { result in
            
            switch result{
            case .success(let message):
                self.tickets=message.tickets
                DispatchQueue.main.async {
                    
                    comlete()
                    
                }
                
                
                
            case .failure(let error):
                print ("error: \(error)")
                
            }
        })
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


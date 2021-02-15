//
//  HomeViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var topHeader: UIImageView!
    @IBOutlet weak var tableView: UITableView!
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
        
        
        return cell;
        
        
    }
    func getDataFromServer(comlete: @escaping()->()){
        let myValue = Configuration.value(defaultValue: "default_value", forKey: "userid")
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

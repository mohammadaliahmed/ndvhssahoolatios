//
//  NoticeBoardController.swift
//  ndvhssahoolat
//
//  Created by MIS on 09/02/2021.
//

import UIKit

class NoticeBoardController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var notices=[NoticeModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.navigationController?.isNavigationBarHidden = true
        getDataFromServer {
            self.tableView.reloadData()
        }
        tableView.delegate=self
        tableView.dataSource=self
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //            let cell = UITableViewCell(style:.default,reuseIdentifier: nil)
        //            cell.textLabel?.text=tickets[indexPath.row].subject
        let cell=tableView.dequeueReusableCell(withIdentifier: "customNoticeCell") as! CustomCellController
        
        cell.subj.text=notices[indexPath.row].title!
        cell.desc.text=notices[indexPath.row].description!
        
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
        
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",phone: "", password: "",id: 1)
        
        
        
        let apiRequest=APIRequest(endpoint: "ticket/notices")
        apiRequest.hometickets(postRequest: postRequest, completion: { result in
            switch result{
            case .success(let message):
                self.notices=message.notices
                
                
                DispatchQueue.main.async {
                    comlete()
                    
                }
                
                
                
            case .failure(let error):
                print ("error: \(error)")
                
            }
        })
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

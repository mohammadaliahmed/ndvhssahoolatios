//
//  HomeViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
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
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//            let cell = UITableViewCell(style:.default,reuseIdentifier: nil)
//            cell.textLabel?.text=tickets[indexPath.row].subject
        let cell=tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCellController
        cell.subj.text=tickets[indexPath.row].subject!
//        cell.descriptionLBL.text=tickets[indexPath.row].description!
        
            return cell;
            
        
    }
    func getDataFromServer(comlete: @escaping()->()){
        
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",phone: "", password: "",id: "2")
       
       
       
               let apiRequest=APIRequest(endpoint: "ticket/allTickets")
               apiRequest.hometickets(postRequest: postRequest, completion: { result in
                   switch result{
                   case .success(let message):
                    self.tickets=message.tickets
                    print(message.tickets[1].subject!)
        
                    DispatchQueue.main.async {
                        comlete()
                          
                    }
                    
                        
                    
                   case .failure(let error):
                       print ("error: \(error)")
       
                   }
               })
        
        
        
        
        
        
//        let myValue = Configuration.value(defaultValue: "default_value", forKey: "userid")
//
//        let parameters = ["id": myValue,"api_username":"WF9.FJ8u'FP{c5Pw","api_password":"3B~fauh5s93j[FKb"] as [String : Any]
//
//        //create the url with URL
//        let url = URL(string: "http://sahoolat.ndvhs.com/api/ticket/homeTickets")! //change the url
//
//        //create the session object
//        let session = URLSession.shared
//
//        //now create the URLRequest object using the url object
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST" //set http method as POST
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//        } catch let error {
//            print(error.localizedDescription)
//        }
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//
//            guard error == nil else {
//                return
//            }
//
//            guard let data = data else {
//                return
//            }
//
//            do {
//                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
////                    print(json)
//                    let resultt=try JSONDecoder().decode(APIResponse.self, from:data)
//
//                    print( resultt.tickets[1].subject!)
//
//                    // handle json...
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        })
//        task.resume()
        
        
        
        
        //        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",phone:  "",password: "",id: myValue)
        //
        //
        //
        //               let apiRequest=APIRequest(endpoint: "ticket/homeTickets")
        //               apiRequest.homeTickets(postRequest: postRequest, completion: { result in
        //                   switch result{
        //                   case .success(let message):
        //                       print("done: \(message)")
        //
        //                    DispatchQueue.main.async {
        //
        //
        //                    }
        //
        //
        //
        //                   case .failure(let error):
        //                       print ("error: \(error)")
        //
        //                   }
        //               })
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

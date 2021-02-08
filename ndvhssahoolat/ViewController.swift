//
//  ViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 03/02/2021.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",phone: phoneNumber.text ?? "",password: password.text ?? "")
        
        
        
        let apiRequest=APIRequest(endpoint: "user/login")
        apiRequest.loginUser(postRequest: postRequest, completion: { result in
            switch result{
            case .success(let message):
                print("done: \(message)")
            case .failure(let error):
                print ("error: \(error)")
            
            }
        })
        
        
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        Configuration.value(value: "my_value", forKey: "key_1")
        let myValue = Configuration.value(defaultValue: "default_value", forKey: "key_1")
        self.hideKeyboardWhenTappedAround()
        print(myValue)

//        fetchData()
        
        
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        table.dataSource=self
        // Do any additional setup after loading the view.
    }
//    func fetchData(){
//        guard let url=URL(string:"https://tools.learningcontainer.com/sample-json.json") else {
//            return
//        }
//        URLSession.shared.dataTask(with: url){
//            (data,response,error) in
//            guard let okData=datas else{
//                return
//            }
//            do{
//                let person=try JSONDecoder().decode(Person.self,from:okData)
//                DispatchQueue.main.async {
//                    self.firstName.text=person.firstName
//                    self.lastName.text=person.lastName
//                    self.gender.text=person.gender
//                    self.age.text=String(person.age)
//                }
//            }catch{
//                print("error")
//            }
//
//        }.resume()
//    }
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }

//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell=tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
//        cell.textLabel?.text=data[indexPath.row]
//        return cell
//    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//
//  ViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 03/02/2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var age: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Configuration.value(value: "my_value", forKey: "key_1")
        let myValue = Configuration.value(defaultValue: "default_value", forKey: "key_1")
            
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


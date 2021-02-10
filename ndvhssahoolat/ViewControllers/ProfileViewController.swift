//
//  ProfileViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 09/02/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var block: UITextField!
    @IBOutlet weak var housenumber: UITextField!
    @IBOutlet weak var phone: UITextField!
    
   
    @IBAction func updateBtn(_ sender: Any) {
        
        let myValue = Configuration.value(defaultValue: "default_value", forKey: "userid")
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",id: myValue,name: name.text ?? "",
                                    phone: phone.text ?? "",housenumber: housenumber.text ?? "",block: block.text ?? "",gender: "Male")



               let apiRequest=APIRequest(endpoint: "user/updateProfile")
               apiRequest.updateProfile(postRequest: postRequest, completion: { result in
                   switch result{
                   case .success(let message):
                    print("done: \(message)")
                    Configuration.value(value: String(message.user.id!), forKey: "userid")
                    Configuration.value(value: ""+message.user.name, forKey: "name")
                    Configuration.value(value: ""+message.user.username, forKey: "username")
                    Configuration.value(value: ""+message.user.phone, forKey: "phone")
                    Configuration.value(value: ""+message.user.housenumber, forKey: "house")
                    Configuration.value(value: ""+message.user.block, forKey: "block")
                    Configuration.value(value: ""+message.user.email, forKey: "email")
                    Configuration.value(value: ""+message.user.avatar, forKey: "avatar")
                    let myValue = Configuration.value(defaultValue: "default_value", forKey: "userid")
                    print(myValue)
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                                mainTabBarController.modalPresentationStyle = .fullScreen
                                self.present(mainTabBarController, animated: true, completion: nil)

                    }



                   case .failure(let error):
                       print ("error: \(error)")

                   }
               })
        
    }
    
   
    @IBAction func logoutBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure to logout?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in
            Configuration.value(value: "default_value", forKey: "userid")
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainNavigationController")
                mainTabBarController.modalPresentationStyle = .fullScreen
                self.present(mainTabBarController, animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setupData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.tappedMe))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    @objc func tappedMe()
    {
        print("Tapped on Image")
    }
    
    func setupData(){
        name.text=Configuration.value(defaultValue: "default_value", forKey: "name")
        phone.text=Configuration.value(defaultValue: "default_value", forKey: "phone")
        housenumber.text=Configuration.value(defaultValue: "default_value", forKey: "house")
        block.text=Configuration.value(defaultValue: "default_value", forKey: "block")
        email.text=Configuration.value(defaultValue: "default_value", forKey: "email")
        
        
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

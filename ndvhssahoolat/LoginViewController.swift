//
//  LoginViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBAction func forgotPassword(_ sender: Any) {
    }
    @IBAction func loginButton(_ sender: Any) {
        
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",phone: phonenumber.text ?? "",password: password.text ?? "",id: "1")
       
       
       
               let apiRequest=APIRequest(endpoint: "user/login")
               apiRequest.loginUser(postRequest: postRequest, completion: { result in
                   switch result{
                   case .success(let message):
                    print("done: \(message)")
                    Configuration.value(value: ""+message.user.id, forKey: "userid")
                    Configuration.value(value: ""+message.user.name, forKey: "name")
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
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()

    }
 

}



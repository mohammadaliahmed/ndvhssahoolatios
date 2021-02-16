//
//  RegisterController.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import UIKit
import Toast_Swift

class RegisterController: UIViewController {
    
    
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var block: UITextField!
    @IBOutlet weak var housenumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    
    
    @IBAction func registerBtn(_ sender: Any) {
        if(nameTf.text==""){
            self.view.makeToast("Please enter name", duration: 1.0)
        }else if(phone.text==""){
            self.view.makeToast("Please enter name", duration: 1.0)
        }else if(phone.text!.count<10){
            self.view.makeToast("Please enter correct phone number", duration: 1.0)
        }else if(housenumber.text==""){
            self.view.makeToast("Please enter house number", duration: 1.0)
        }else if(block.text==""){
            self.view.makeToast("Please enter Block", duration: 1.0)
        }else if(email.text==""){
            self.view.makeToast("Please enter email", duration: 1.0)
        }else if(password.text==""){
            self.view.makeToast("Please enter password", duration: 1.0)
        }else{
            registerNow()
        }
        
    }
    func registerNow()  {
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",
                                    api_password: "3B~fauh5s93j[FKb",
                                    username: phone.text ?? "",
                                    name: nameTf.text ?? "" ,
                                    phone: phone.text ?? "",
                                    housenumber: housenumber.text ?? "",
                                    block: block.text ?? "",
                                    email: email.text ?? "",
                                    password: password.text ?? "")
        
        
        
        let apiRequest=APIRequest(endpoint: "user/register")
        apiRequest.loginUser(postRequest: postRequest, completion: { result in
            switch result{
            case .success(let message):
                print("done: \(message)")
                if(message.user==nil){
                    DispatchQueue.main.async {
                    self.view.makeToast(message.message, duration: 1.0)
                    }
                }else{
                    
                    let defaults = UserDefaults.standard
                    defaults.set(message.user.id, forKey: "userid")
                    defaults.set(message.user.name, forKey: "name")
                    defaults.set(message.user.phone, forKey: "phone")
                    
                    defaults.set(message.user.housenumber, forKey: "housenumber")
                    defaults.set(message.user.block, forKey: "block")
                    defaults.set(message.user.email, forKey: "email")
                    defaults.set(message.user.avatar, forKey: "avatar")
                   
                    let myValue = defaults.integer(forKey: "userid")
                   
                    print(myValue)
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                        mainTabBarController.modalPresentationStyle = .fullScreen
                        self.present(mainTabBarController, animated: true, completion: nil)
                        
                    }
                }
                
                
                
            case .failure(let error):
                print ("error: \(error)")
                
            }
        })
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "loginStory")
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboadDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        phone.keyboardType = UIKeyboardType.phonePad
        housenumber.keyboardType = UIKeyboardType.phonePad
        
        
    }
    var isExpanded:Bool=false
    
    @objc func keyboardAppear(){
        if(!isExpanded){
            self.scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
            isExpanded=true
        }
    }
    @objc func keyboadDisappear(){
        if(isExpanded){
            self.scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height-100)
            isExpanded=false
        }
    }
    
    
    
}

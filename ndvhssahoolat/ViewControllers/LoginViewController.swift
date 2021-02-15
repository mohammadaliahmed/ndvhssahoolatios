//
//  LoginViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBAction func registerBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "registerStory")
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
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
                if(message.user==nil){
                    DispatchQueue.main.async {self.showToast(message: message.message, font: .systemFont(ofSize: 12.0))
                    }
                }else{
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
extension UIViewController {
    
    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let maxTitleSize = CGSize(width: view.bounds.size.width * maxWidthPercentage, height: view.bounds.size.height * maxWidthPercentage)
        var titleSize = toastLabel.sizeThatFits(maxTitleSize)
        titleSize.width += 20
        titleSize.height += 10
        toastLabel.frame = CGRect(x: view.frame.size.width / 2 - titleSize.width / 2, y: view.frame.size.height - 50, width: titleSize.width, height: titleSize.height)
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
    
}

//
//  ViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 03/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        Configuration.value(value: "my_value", forKey: "key_1")
        let myValue = Configuration.value(defaultValue: "default_value", forKey: "userid")
        self.hideKeyboardWhenTappedAround()
        print(myValue)
        if(myValue=="default_value"){
            
            performSegue(withIdentifier: "loginView", sender: self)
            
        }else{
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                mainTabBarController.modalPresentationStyle = .fullScreen
                
                self.present(mainTabBarController, animated: true, completion: nil)
            }
        }
        
        
    }
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

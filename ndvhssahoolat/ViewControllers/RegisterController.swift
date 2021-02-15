//
//  RegisterController.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var name: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var block: UITextField!
    @IBOutlet weak var housenumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
   

    
    @IBAction func registerBtn(_ sender: Any) {
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

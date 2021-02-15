//
//  ProfileViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 09/02/2021.
//

import UIKit
import YPImagePicker
import SwiftUI
import WXImageCompress

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @State var selectedImage: Image? = Image("")
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var block: UITextField!
    @IBOutlet weak var housenumber: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    let imgUri:String! = nil
    var imgSelected:Bool = false
    var liveUrl:String!
    var textFields: [UITextField] {
            return [name, phone, housenumber, block,email]
        }
    
    @IBAction func updateBtn(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Saving profile...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        if(imgSelected){
            uploadImage()
        }else{
            savedata()
        }
        
        //
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
    
    public  func savedata(){
        
        let myValue = Configuration.value(defaultValue: "default_value", forKey: "userid")
        let usenr = Configuration.value(defaultValue: "default_value", forKey: "username")
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",id: myValue,username: usenr,name: name.text ?? "",
                                    phone: phone.text ?? "",housenumber: housenumber.text ?? "",block: block.text ?? "",gender: "Male",liveUrl: liveUrl)
        
        
        
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
//                print(myValue)
               
                DispatchQueue.main.async {
                    self.dismiss(animated: false, completion: nil)
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
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setupData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.tappedMe))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imgSelected=false
        self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
        self.imageView.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    func uploadImage(){
        
        let uiImage: UIImage = self.imageView.image!
        
        //                let imageData = uiImage.compress(to: 300)
        let uiImages = uiImage.wxCompress()
        
        let imageData: Data = uiImages.jpegData(compressionQuality: 0.1) ?? Data()
        let imageStr: String = imageData.base64EncodedString()
        
        // send request to server
        guard let url: URL = URL(string: "http://test.ndvhs.com/index.php") else {
            print("invalid URL")
            return
        }
        
        // create parameters
        let paramStr: String = "image=\(imageStr)"
        let paramData: Data = paramStr.data(using: .utf8) ?? Data()
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = paramData
        
        // required for sending large data
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // send the request
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { [self] (data, response, error) in
            guard let data = data else {
                print("invalid data")
                return
            }
            
            // show response in string
            let responseStr: String = String(data: data, encoding: .utf8) ?? ""
            print(responseStr)
            self.liveUrl=responseStr
            self.savedata()
        })
        .resume()
        
        
        
    }
    
    
    
    
    @objc func tappedMe()
    {
        print("Tapped on Image")
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                self.imageView.image=photo.image
                self.imgSelected=true
                
            }
            picker.dismiss(animated: true, completion: nil)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                for item in items {
                    switch item {
                    case .photo(let photo):
                        print(photo)
                    case .video(let video):
                        print(video)
                    }
                }
                picker.dismiss(animated: true, completion: nil)
            }
        }
        present(picker, animated: true, completion: nil)
        //        let imagePickerController = ImagePickerController()
        //        imagePickerController.delegate = self
        //        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func setupData(){
        name.text=Configuration.value(defaultValue: "default_value", forKey: "name")
        phone.text=Configuration.value(defaultValue: "default_value", forKey: "phone")
        housenumber.text=Configuration.value(defaultValue: "default_value", forKey: "house")
        block.text=Configuration.value(defaultValue: "default_value", forKey: "block")
        email.text=Configuration.value(defaultValue: "default_value", forKey: "email")
       
        liveUrl=Configuration.value(defaultValue: "default_value", forKey: "avatar")
        
        var imgUrl="http://sahoolat.ndvhs.com/storage/"+liveUrl
        if let url = URL(string: imgUrl) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.imageView.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
        
       
        textFields.forEach { $0.delegate = self }
        
        
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
                textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder() // last textfield, dismiss keyboard directly
            }
            return true
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


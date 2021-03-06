//
//  CreateTicketController.swift
//  ndvhssahoolat
//
//  Created by MIS on 10/02/2021.
//

import UIKit
import YPImagePicker
import SwiftUI
import WXImageCompress
import Toast_Swift

class CreateTicketController: UIViewController{
    
    @IBOutlet weak var departmentTF: UITextField!
    @IBOutlet weak var priorityTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
 
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @IBAction func submitBtn(_ sender: Any) {
        
        
        
        if(departmentId==nil){
            self.view.makeToast("Please select department", duration: 1.0)
        }else if (priorityTF.text==""){
            self.view.makeToast("Please select priority", duration: 1.0)
        }
        else if(titleTF.text!.count<5){
            self.view.makeToast("Please enter title", duration: 1.0)
        }else if (descriptionTF.text==""){
            self.view.makeToast("Please description", duration: 1.0)
        }
        else if (descriptionTF.text!.count<10){
            self.view.makeToast("Please explain your problem", duration: 1.0)
        }else{
            
            
            let alert = UIAlertController(title: "Alert", message: "Create ticket?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in
                let alert2 = UIAlertController(title: nil, message: "Creating Ticket...", preferredStyle: .alert)
                
                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.startAnimating();
                
                alert2.view.addSubview(loadingIndicator)
                self.present(alert2, animated: true, completion: nil)
                if(self.imgSelected){
                    self.uploadImage()
                }else{
                    self.createTicket {
                        
                        DispatchQueue.main.async {self.showToast(message: "Done", font: .systemFont(ofSize: 12.0))
                        }
                    }
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
            
            
           
        }
    }
    
    var departmentsList=[DepartmentModel]()
    let priorities = ["low","medium","high"]
    
    var departmentPickerView=UIPickerView()
    var prioritiyPickerView=UIPickerView()
    var departmentId:String!
    var liveUrl:String!
    var imgSelected:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
        let myColor = UIColor.lightGray
        descriptionTF.layer.borderColor=myColor.cgColor
        descriptionTF.layer.borderWidth = 0.6
        descriptionTF.layer.cornerRadius = 6.0
        
        departmentTF.inputView = departmentPickerView
        priorityTF.inputView = prioritiyPickerView
        
        departmentPickerView.delegate = self
        departmentPickerView.dataSource = self
        
        prioritiyPickerView.delegate = self
        prioritiyPickerView.dataSource = self
        
        departmentPickerView.tag=1
        prioritiyPickerView.tag=2
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.tappedMe))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
        
        getDataFromServer {
            self.reloadInputViews()
        }
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboadDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
//
        
        // Do any additional setup after loading the view.
    }
    var isExpanded:Bool=false
    
//    @objc func keyboardAppear(){
//        if(!isExpanded){
//            self.scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height+150)
//            isExpanded=true
//        }
//    }
//    @objc func keyboadDisappear(){
//        if(isExpanded){
//            self.scrollView.contentSize=CGSize(width: self.view.frame.width, height: self.view.frame.height-150)
//            isExpanded=false
//        }
//    }
    @objc func tappedMe()
    {
        print("Tapped on Image")
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                //                print(photo.fromCamera) // Image source (camera or library)
                //                print(photo.image) // Final image selected by the user
                //                print(photo.originalImage) // original image selected by the user, unfiltered
                //                print(photo.modifiedImage) // Transformed image, can be nil
                //                print(photo.exifMeta) // Print exif meta data of original image.
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
    
    
    
    func createTicket(comlete: @escaping()->()){
        
        let defaults = UserDefaults.standard
        let myValue = defaults.integer(forKey: "userid")
        var postRequest:PostRequest!
        if(imgSelected){
            postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",id: myValue ,title: titleTF.text  ?? "",
                                    description: descriptionTF.text ?? "",priority: priorityTF.text ?? "" , department_id: departmentId,liveUrl: liveUrl)
        }
        else{
            postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",id: myValue ,title: titleTF.text  ?? "",
                                    description: descriptionTF.text ?? "",priority: priorityTF.text ?? "" , department_id: departmentId)
        }
        
        
        let apiRequest=APIRequest(endpoint: "ticket/createTicket")
        apiRequest.createTicket(postRequest: postRequest, completion: { result in
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                mainTabBarController.modalPresentationStyle = .fullScreen
                self.present(mainTabBarController, animated: true, completion: nil)
            }
            
            
        })
    }
    
    func getDataFromServer(comlete: @escaping()->()){
        
        
        
        let postRequest=PostRequest(api_username: "WF9.FJ8u'FP{c5Pw",api_password: "3B~fauh5s93j[FKb",phone: "", password: "",id: 1)
        
        let apiRequest=APIRequest(endpoint: "ticket/getDepartments")
        apiRequest.hometickets(postRequest: postRequest, completion: { result in
            switch result{
            case .success(let message):
                self.departmentsList=message.departments
                
                
                DispatchQueue.main.async {
                    comlete()
                    
                }
                
                
                
            case .failure(let error):
                print ("error: \(error)")
                
            }
        })
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
            self.createTicket {
                
                DispatchQueue.main.async {self.showToast(message: "Done", font: .systemFont(ofSize: 12.0))
                }
            }
            
        })
        .resume()
        
        
        
    }
    
}





extension CreateTicketController: UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return departmentsList.count
        case 2:
            return priorities.count
        default:
            return 1
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return departmentsList[row].name
        case 2:
            return priorities[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            departmentTF.text=departmentsList[row].name
            departmentTF.resignFirstResponder()
            departmentId=departmentsList[row].id
        case 2:
            priorityTF.text=priorities[row]
            priorityTF.resignFirstResponder()
        default:
            return
        }
    }
}



//
//  PostRequest.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import Foundation

class PostRequest:Codable{
    let api_username:String
    let api_password:String
    let phone:String
    let password:String
    
    
    init(api_username:String,api_password:String,phone:String,password:String) {
        self.api_username=api_username
        self.api_password=api_password
        self.phone=phone
        self.password=password
        
    }
    
}

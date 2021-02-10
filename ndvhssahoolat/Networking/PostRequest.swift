//
//  PostRequest.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import Foundation

class PostRequest:Codable{
    var api_username:String!
    var api_password:String!
    var phone:String!
    var password:String!
    var id:String!
    
    var name:String!
    var gender:String!
    var housenumber:String!
    var block:String!
    
    var department_id:String!
    var priority:String!
    var title:String!
    var description:String!
    
    
    
    
    init(api_username:String,api_password:String,phone:String,password:String,id:String) {
        self.api_username=api_username
        self.api_password=api_password
        self.phone=phone
        self.password=password
        self.id=id
        
    }
    
    
    init(api_username:String,api_password:String,id:String,title:String,description:String,priority:String,department_id:String) {
        self.api_username=api_username
        self.api_password=api_password
        self.title=title
        self.id=id
        self.priority=priority
        self.description=description
        self.department_id=department_id
    
        
    }
    
    
    
    init(api_username:String,api_password:String,id:String,name:String,phone:String,housenumber:String,block:String,gender:String) {
        self.api_username=api_username
        self.api_password=api_password
        self.phone=phone
        self.id=id
    
        self.housenumber=housenumber
        self.block=block
        self.gender=gender
        self.name=name
        
    }
    
    

}

//
//  Person.swift
//  ndvhssahoolat
//
//  Created by MIS on 04/02/2021.
//

import Foundation

struct Person:Codable
{
    let firstName:String
    let lastName:String
    let gender:String
    let age:Int
    
    init() {
        firstName=""
        lastName=""
        gender=""
        age=0
    }
}

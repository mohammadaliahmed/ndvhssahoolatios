//
//  UserModel.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import Foundation


struct User: Codable {
    var id, name, username, email: String!
    var password, avatar: String!
    var designation, departmentID, rememberToken, createdAt: String!
    var updatedAt: String!
    var housenumber, block, phone, gender: String!
    var fcmKey, active, code, role: String!

    enum CodingKeys: String, CodingKey {
        case id, name, username, email, password, avatar, designation
        case departmentID = "department_id"
        case rememberToken = "remember_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case housenumber, block, phone, gender, fcmKey, active, code, role
    }
}

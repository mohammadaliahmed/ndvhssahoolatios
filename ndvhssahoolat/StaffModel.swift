//
//  StaffModel.swift
//  ndvhssahoolat
//
//  Created by MIS on 09/02/2021.
//

import Foundation
struct Staff: Codable {
    let id: Int
    let name, username, email, avatar: String
    let designation, departmentID: String
    let createdAt, updatedAt, housenumber, block: String
    let phone: String
    let gender: String
    let active: String

    enum CodingKeys: String, CodingKey {
        case id, name, username, email, avatar, designation
        case departmentID = "department_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case housenumber, block, phone, gender, active
    }
}

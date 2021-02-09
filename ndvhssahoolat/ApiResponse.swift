//
//  ApiResponse.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

struct APIResponse: Codable {
    var code: Int!
    var message: String!
    var user: User!
    var tickets : [Ticket]!
    var ticket : Ticket!
}

// MARK: - User

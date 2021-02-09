//
//  TicketModel.swift
//  ndvhssahoolat
//
//  Created by MIS on 09/02/2021.
//

import Foundation

struct Ticket : Codable {
    var id : String!
    var department_id : String!
    var user_id: String!
    var token_no: String!
    var subject: String!
    var description: String!
    var priority: String!
    var status: String!
    var assignedTo: String!
    var remember_token: String!
    var created_at: String!
    var updated_at: String!
    
}

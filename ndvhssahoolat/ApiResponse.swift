//
//  ApiResponse.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

struct APIResponse: Codable {
    let code: Int
    let message: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id, name, username, email: String
    let password, avatar: String
    let designation, departmentID, rememberToken, createdAt: JSONNull?
    let updatedAt: JSONNull?
    let housenumber, block, phone, gender: String
    let fcmKey, active, code, role: String

    enum CodingKeys: String, CodingKey {
        case id, name, username, email, password, avatar, designation
        case departmentID = "department_id"
        case rememberToken = "remember_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case housenumber, block, phone, gender, fcmKey, active, code, role
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

//
//  User.swift
//  MachineTest-11-2
//
//  Created by Mac on 06/03/23.
//

import Foundation
/*struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}*/
struct User : Decodable{
    var id : Int
    var email : String
    var first_name : String
    var last_name : String
    var  avatar : String
}

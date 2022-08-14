//
//  UserData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let password: String
    let last_login: String
    let is_superuser: Bool
    let username: String
    let email: String
    let is_staff: Bool
    let date_joined: String
    let last_updated: String
    let groups: [String]
    let user_permissions: [String]
    let is_lazy_user: Bool
    let sended_mail: Bool?
    let sended_mail_message: Bool?
}

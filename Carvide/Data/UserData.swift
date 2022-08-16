//
//  UserData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import Foundation

struct UserData: Codable, Identifiable {
    var id: Int
    var password: String
    var last_login: String
    var is_superuser: Bool
    var username: String
    var email: String
    var is_staff: Bool
    var date_joined: String
    var last_updated: String
    var groups: [String]
    var user_permissions: [String]
    var is_lazy_user: Bool
    var sended_mail: Bool?
    var sended_mail_message: Bool?
}

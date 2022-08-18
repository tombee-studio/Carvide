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
    var user_permissions: [Int]
    var is_lazy_user: Bool
    var sended_mail: Bool?
    var sended_mail_message: String?
    
    static func createGuestUserData() -> UserData {
        let user = UserData(
            id: 0,
            password: "",
            last_login: "",
            is_superuser: false,
            username: "",
            email: "testuser@test_domain.com",
            is_staff: false,
            date_joined: "",
            last_updated: "",
            groups: ["Guest"],
            user_permissions: [],
            is_lazy_user: false,
            sended_mail: nil,
            sended_mail_message: nil
        )
        return user
    }
}

//
//  LoginViewController.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import Foundation

struct LoginViewController {
    let view: LoginView
    let model: EmonotateModel
    
    public func login(_ username: String, _ password: String) async {
        await model.login(username, password)
        if(model.user == nil) {
            await view.failedLoadUserData()
        } else {
            await view.successLoadUserData()
        }
    }
}

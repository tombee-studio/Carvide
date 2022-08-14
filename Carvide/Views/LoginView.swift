//
//  ContentView.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var model = EmonotateModel()

    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Carvide")
                .font(.system(size: 48,
                              weight: .heavy))
            VStack(spacing: 24) {
                TextField("User Name", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .frame(maxWidth: 320)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 320)
            }
            .frame(height: 200)
            Button(action: {
                Task.init {
                    await LoginViewController(view: self, model: model)
                        .login(username, password)
                }
            },
            label: {
                Text("Login")
                    .fontWeight(.medium)
                    .frame(minWidth: 160)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            })

            Spacer()
        }
    }
    
    public func failedLoadUserData() {
        print("failed")
    }
    
    public func successLoadUserData() {
        print("success")
    }
}

struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.portrait)
    }
}

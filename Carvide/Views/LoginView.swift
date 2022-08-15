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

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isNextView: Bool = false
    
    var body: some View {
        NavigationView {
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
                NavigationLink(
                    destination: ContentView(model: model),
                    isActive: $isNextView,
                    label: {
                        Button(action: {
                            Task.init {
                                await LoginViewController(view: self, model: model)
                                    .login(username, password)
                                self.isNextView.toggle()
                            }
                        }) {
                            Text("ログイン")
                        }
                    })
            }
        }
        .padding()
        .navigationTitle("Carvide")
        .navigationBarHidden(false)
        .navigationViewStyle(.stack)
    }
    
    public func failedLoadUserData() {
        print("failed")
    }
    
    public func successLoadUserData() {
        
    }
}

struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.portrait)
    }
}

//
//  ProfileView.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import SwiftUI

struct ProfileView: View {
    @State var userData: UserData? = nil

    var body: some View {
        if let userData = self.userData {
            VStack(alignment: .center) {
                Text(userData.username).font(.system(size: 48))
                Text(userData.email).font(.system(size: 36))
                Spacer()
            }
        } else {
            VStack(alignment: .center) {
                Text("お待ちください").font(.system(size: 60))
            }.task {
                let model = EmonotateModel()
                if let tmpUserData = await model.getMe() {
                    userData = tmpUserData
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}

//
//  ContentView.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: EmonotateModel
    
    init(model: EmonotateModel) {
        self.model = model
    }
    
    var body: some View {
        TabView {
            ProfileView().tabItem() {
                Image(systemName: "1.square.fill")
                Text("Profile").font(.system(size: 24))
            }.navigationTitle("プロファイル")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: EmonotateModel())
    }
}

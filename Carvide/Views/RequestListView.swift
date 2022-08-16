//
//  RequestListView.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import SwiftUI

struct RequestListView: View {
    @State var result: ResultListData<RequestData>? = nil
    
    var body: some View {
        if result != nil {
            if let result = result {
                List {
                    ForEach(result.models) { request in
                        Text(request.title)
                    }
                }
            }
        } else {
            VStack(alignment: .center) {
                Text("お待ちください")
            }.task {
                let model = EmonotateModel()
                if let requestList = await model.getRequestList() {
                    self.result = requestList
                }
            }
        }
    }
}

struct RequestListView_Previews: PreviewProvider {
    static var previews: some View {
        RequestListView()
    }
}

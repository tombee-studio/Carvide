//
//  RequestListView.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import SwiftUI

struct RequestListView: View {
    @State var requestList: ResultListData<RequestData>
    
    init(requestList: ResultListData<RequestData>) {
        self.requestList = requestList
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct RequestListView_Previews: PreviewProvider {
    static var previews: some View {
        RequestListView(
            requestList: try! ResultListData<RequestData>(
                from: JSONDecoder() as! Decoder))
    }
}

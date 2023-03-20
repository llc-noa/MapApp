//
//  ContentView.swift
//  MapApp
//
//  Created by 菅谷亮太 on 2023/03/15.
//

import SwiftUI

struct ContentView: View {
    @State var inputText:String = ""
    @State var displaySearchKey:String = ""
    @State var displayMapType:MapType = .standard
    var body: some View {
        VStack {
            TextField("キーワード",text: $inputText,prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    displaySearchKey = inputText
                }
                .padding()
            ZStack(alignment: .bottomTrailing){
                Mapview(searchKey: displaySearchKey,mapType:displayMapType)
                Button{
                    if displayMapType == .standard{
                        displayMapType = .satellite
                    }
                    else if displayMapType == .satellite{
                        displayMapType = .hybrid
                    }else{
                        displayMapType = .standard
                    }
                }label: {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0,height: 35.0)
                }
                .padding(.trailing,20.0)
                .padding(.bottom,30.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

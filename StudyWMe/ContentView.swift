//
//  ContentView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            LoginView(model: ModelData())
        }.navigationViewStyle(StackNavigationViewStyle()) //Need this for iPad screens to force stack naviagtion view
        
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject var model = ModelData()
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}



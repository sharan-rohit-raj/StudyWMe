//
//  ContentView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-12.
//

import SwiftUI
import Firebase

struct ContentView: View {
    //User status
    @AppStorage("log_Status") var userStatus = false
    
    var body: some View {
        ZStack{
            if userStatus {
                VStack(spacing: 25){
                    Text("Logged in as \(Auth.auth().currentUser?.email ?? "")")
                    Button("Logout"){
                        //Logout
                    }
                }
            }else{
                NavigationView{
                    LoginView(model: ModelData())
                }.navigationViewStyle(StackNavigationViewStyle()) //Need this for iPad screens to force stack naviagtion view
            }
        }
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



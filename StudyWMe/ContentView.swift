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
    @EnvironmentObject var session: FirebaseAuthentication
    
    //listen to the changes in the user state
    func getUser() {
        session.listenForChangesInState()
    }
    
    var body: some View {
        ZStack{
            //User is logged in
            if session.session != nil{
                MainView()
            }else{
                NavigationView{
                    LoginView()
                }.navigationViewStyle(StackNavigationViewStyle()) //Need this for iPad screens to force stack naviagtion view
            }
//            if userStatus {
//                MainView()
//            }else{
//                NavigationView{
//                    LoginView()
//                }.navigationViewStyle(StackNavigationViewStyle()) //Need this for iPad screens to force stack naviagtion view
//            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(FirebaseAuthentication())
        }
    }
}



//
//  HomeView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-25.
//

import SwiftUI
import Firebase

struct MainView: View {
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @StateObject var menuModel = MenuModel()
    @Namespace var animation
    var body: some View {
            ZStack {
                GeometryReader{ geometry in
                    HStack{
                        //Drawer
                        Drawer(animation: animation)
                        //Main View
                        TabView(selection: $menuModel.selectedMenu){
                            FlashQuizView()
                                .tag("Home")
                            ProfileView()
                                .tag("Profile")
                            FeedbackView()
                                .tag("Feedback")
                            AboutUsView()
                                .tag("About Us")
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(x: menuModel.showDrawer ?  175 : -175)
                    .overlay(
                        ZStack {
                            if !menuModel.showDrawer{
                                DrawerCloseButton(animation: animation)
                                    .padding()
                            }
                        },
                        alignment: .topLeading
                    )
                    .environmentObject(menuModel)

                }
            }//ZStack
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

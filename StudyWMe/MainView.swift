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
    //Flash Card Category
    @ObservedObject var flashCardsCategories: FlashCardCategories = FlashCardCategories()
    @ObservedObject var quizCardCategoriesModel: QuizCardCategories = QuizCardCategories()
    @State var displayName = Auth.auth().currentUser?.displayName ?? "Student"
    var body: some View {
            ZStack {
                GeometryReader{ geometry in
                    HStack{
                        //Drawer
                        Drawer(animation: animation)
                        //Main View
                        TabView(selection: $menuModel.selectedMenu){
                            FlashQuizView(flashCardsCategories: flashCardsCategories, quizCardCategoriesModel: quizCardCategoriesModel )
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
            .onAppear {
                displayName = Auth.auth().currentUser?.displayName ?? "Student"
                self.flashCardsCategories.fetchData(studentUID: Auth.auth().currentUser!.uid)
                self.quizCardCategoriesModel.fetchData(studentUID: Auth.auth().currentUser!.uid)
            }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

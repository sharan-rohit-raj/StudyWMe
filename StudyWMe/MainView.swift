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
    @ObservedObject var profileModel: ProfileModel = ProfileModel()
    @State var displayName = Auth.auth().currentUser?.displayName ?? "Student"
    @State var studentUID = Auth.auth().currentUser?.uid
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
                            ProfileView(model: self.profileModel)
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
                self.flashCardsCategories.fetchData(studentUID: studentUID!)
                self.quizCardCategoriesModel.fetchData(studentUID: studentUID!)
                self.profileModel.fetchProfileData(userUID: studentUID!)
            }
            .onDisappear {
                //Detach all the listeners when you dont need them
                self.flashCardsCategories.detachListenerForFlashCardCategories()
                self.quizCardCategoriesModel.detachListenerForQuizCardCategories()
                self.profileModel.detachProfileDataListener()
            }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

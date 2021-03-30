//
//  ProfileView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-26.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var model : ProfileModel = ProfileModel()
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    var body: some View {
        NavigationView{

            VStack {
                VStack(spacing: 30) {
                    Text("Profile")
                        .font(Font.custom("Noteworthy", size: 35).bold())
                        .foregroundColor(Color("DarkPurple"))
                        .frame(width: UIScreen.main.bounds.width , height: 150, alignment: .bottomLeading)
                        .offset(x: 15, y: 0)
                    Text("Here's little something about you. Feel free to edit.")
                        .font(Font.custom("Noteworthy", size: 25).bold())
                        .foregroundColor(Color("DarkPurple"))
                        .frame(width: UIScreen.main.bounds.width , alignment: .bottomLeading)
                        .offset(x: 15, y: 0)
                }
            
                VStack(spacing: 50) {
                    CustomTextField(image: "person.fill", placeholderValue: "First Name", text: $model.firstName)
                    CustomTextField(image: "person.fill", placeholderValue: "Last Name", text: $model.lastName)
                    CustomTextField(image: "phone.fill", placeholderValue: "Phone Number", text: $model.phoneNumber)
                    CustomTextField(image: "envelope.fill", placeholderValue: "Email ID", text: $model.emailId)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                }.padding(.top, (UIScreen.main.bounds.height * 0.5) - 430)
                
                Button(action: {}, label: {
                    Text("Save").font(Font.custom("Noteworthy", size: 20).bold())
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color("DarkPurple"))
                        .clipShape(Capsule())
                }).padding(.top, UIScreen.main.bounds.height * 0.1)
                Spacer()
            }//VStack
            .edgesIgnoringSafeArea(.top)
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1))

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)


    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

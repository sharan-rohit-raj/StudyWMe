//
//  Drawer.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-25.
//

import SwiftUI
import Firebase

struct Drawer: View {
    @EnvironmentObject var menuModel: MenuModel
    var animation: Namespace.ID
    @State var displayName = Auth.auth().currentUser?.displayName ?? "Student"
    
    
    //Function to decide the salutation for the user
    func salutation()-> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        var salutation: String = "Good Day,"
        
        if hour >= 6 && hour < 12 {
            salutation = "Good Morning,"
        }
        else if hour >= 12 && hour < 16 {
            salutation = "Good Afternoon,"
        }
        else if hour >= 16 && hour < 20 {
            salutation = "Good Evening,"
        }
        else if hour >= 20 && hour < 24 {
            salutation = "Nighty Night,"
        }
        else if hour >= 1 && hour < 6 {
            salutation = "Sleep tight,"
        }
        
        return salutation
    }
    
    var body: some View {
        VStack{
            HStack{
                Image("default_account")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                Spacer()
                //Close Button
                if menuModel.showDrawer{
                    DrawerCloseButton(animation: animation)
                }
            }//HStack
            .padding(.horizontal)
            .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text(salutation())
                    .font(.title2)
                Text(displayName)
                    .font(.title)
                    .fontWeight(.heavy)
                
            })
            .foregroundColor(.white)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 30)
            
            //Menu Buttons
            VStack(spacing: 45){
                MenuButtons(name: "Home", image: "house.fill", selectedMenu: $menuModel.selectedMenu, animation: animation)
                MenuButtons(name: "Profile",image: "person.crop.circle", selectedMenu: $menuModel.selectedMenu, animation: animation)
                MenuButtons(name: "Feedback",image: "envelope.fill", selectedMenu: $menuModel.selectedMenu, animation: animation)
                MenuButtons(name: "About Us",image: "info.circle.fill", selectedMenu: $menuModel.selectedMenu, animation: animation)
            }
            .padding(.leading)
            .frame(width: 350, alignment: .leading)
            .padding(.top, 30)
            
            Divider()
                .background(Color.white)
                .padding(.top, 30)
                .padding(.horizontal, 25)
            Spacer()
            
            MenuButtons(name: "Sign Out",image: "rectangle.righthalf.inset.fill.arrow.right", selectedMenu: .constant(""), animation: animation)
                .padding(.bottom)
        }//VStack
        .frame(width: 350)
        .cornerRadius(30)
        .background(Color("DarkPurple"))
        .ignoresSafeArea(.all, edges: .vertical)
        .onAppear(perform: {
            displayName = Auth.auth().currentUser?.displayName ?? "Student"
        })
    }
}

struct DrawerCloseButton: View{
    @EnvironmentObject var menuModel: MenuModel
    var animation: Namespace.ID
    
    var body: some View{
        Button(action: {
            withAnimation(.easeOut){
                menuModel.showDrawer.toggle()
            }
        }, label: {
            VStack(spacing: 5){
                Capsule()
                    .fill(menuModel.showDrawer ? Color.white : Color("DarkPurple"))
                    .frame(width: 35, height: 3)
                    .rotationEffect(.init(degrees: menuModel.showDrawer ? -50 : 0))
                    .offset(x: menuModel.showDrawer ? 2 : 0, y: menuModel.showDrawer ? 9 : 0)
                VStack(spacing: 5){
                    Capsule()
                        .fill(menuModel.showDrawer ? Color.white : Color("DarkPurple"))
                        .frame(width: 35, height: 3)
                    Capsule()
                        .fill(menuModel.showDrawer ? Color.white : Color("DarkPurple"))
                        .frame(width: 35, height: 3)
                        .offset(y: menuModel.showDrawer ? -8 : 0)
                }
                .rotationEffect(.init(degrees: menuModel.showDrawer ? 50 : 0))
            }
        })
        .scaleEffect(0.8)
        .matchedGeometryEffect(id: "MENU_BTN", in: animation)
    }
}

struct Drawer_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

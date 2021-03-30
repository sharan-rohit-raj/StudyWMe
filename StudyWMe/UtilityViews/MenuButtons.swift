//
//  MenuButtons.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-26.
//

import SwiftUI
import Firebase

struct MenuButtons: View {
    var name: String
    var image: String
    @Binding var selectedMenu: String
    var animation: Namespace.ID
    @AppStorage("log_Status") var userStatus = true
    @State var isShowDialog = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedMenu = name
                
                //Sign out button was pressed
                if selectedMenu == "" {
                    //Prompt dialog
                    self.isShowDialog.toggle()
                }
            }
        }, label: {
            
            HStack(spacing: 15){
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(selectedMenu == name ? Color("DarkPurple") : .white)
                Text(name)
                    .foregroundColor(selectedMenu == name ? Color("DarkPurple"): .white)
                    .font(.title2)
            }
            .padding(.horizontal)
            .padding(.vertical)
            .frame(width: 300, alignment: .leading)
            .background(
                ZStack{
                    if selectedMenu == name{
                        Color.white.cornerRadius(10)
                            .matchedGeometryEffect(id: "ID", in: animation)
                    }else{
                        Color.clear
                    }
                }
            )
            .cornerRadius(15)
        }).alert(isPresented: $isShowDialog){
            Alert(title: Text("Sign Out"), message: Text("You are about to sign out. Do you wish to proceed?"), primaryButton: .default(Text("Yes")){
                //Sign Out from Firebase
                
            }, secondaryButton: .destructive(Text("No")))
        }
    }
}

struct MenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

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
    @State var firebaseAuth = FirebaseAuthentication()
    @State var isLogOutSuccessful:Bool = false
    @State var alertType: AlertType = .attemptToLogout
    
    enum AlertType {
        case errorLogout, attemptToLogout
    }
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedMenu = name
                
                //Sign out button was pressed
                if selectedMenu == "" {
                    //Prompt dialog
                    alertType = .attemptToLogout
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
            switch (alertType) {
                case .attemptToLogout:
                   return Alert(title: Text("Sign Out"), message: Text("You are about to sign out. Do you wish to proceed?"), primaryButton: .destructive(Text("No")),
                          secondaryButton: .default(Text("Yes")){
                            //Sign Out from Firebase
                            isLogOutSuccessful = firebaseAuth.logout()
                            if !isLogOutSuccessful {
                                alertType = .errorLogout
                                self.isShowDialog.toggle()
                            }
                          })
                case .errorLogout:
                    return Alert(title: Text("Log Out Error"), message: Text("Error occurred when trying to log out."), dismissButton: .default(Text("Okay")))
            }

        }
    }
}

struct MenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  LoginView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-16.
//

import SwiftUI

struct LoginView: View {
    @StateObject var model : ModelData
    @StateObject var authentication = FirebaseAuthentication()
    var body: some View{
            VStack{
                Image("logo")
                    .padding(.horizontal)
                    .padding(.vertical, 25.0)
                    .background(Color("LightPurple").opacity(0.175))
                    .cornerRadius(30)
        
                VStack(spacing:40){
                    Text("StudyWMe")
                        .font(Font.custom("Noteworthy", size: 50).bold())
                        .foregroundColor(Color("PrimaryColor"))
                    Text("Want to get some studying done? Just log in.")
                        .font(Font.custom("Noteworthy", size: 35).bold())
                        .foregroundColor(Color("PrimaryColor"))
                }.padding(.bottom)
            
                VStack(spacing: 20){
                    CustomTextField(image: "user", placeholderValue: "Email ID", text: $model.emailLogin).disableAutocorrection(true)
                    CustomTextField(image: "lock", placeholderValue: "Password", text: $model.passwordLogin)
                    Button(action: authentication.login, label: {
                        Text("Login").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color("DarkPurple"))
                            .clipShape(Capsule())
                        
                    }).padding(.top)
                }.padding(.top)
                
                HStack(spacing: 12){
                    Text("Don't have an account?")
                        .foregroundColor(Color("PrimaryColor").opacity(0.8))
                    
                    //Set up the action to navigate to Sign up page
                    NavigationLink(destination: SignUpView(model: model)){
                            Text("Sign up here")
                                .foregroundColor(Color("DarkPurple"))
                    }
                    
                }.padding(.top)
                
                //Set up the action to navigate to Sign up page
                NavigationLink(destination: ForgotPasswordView(model: model)){
                        Text("Forgot Password?")
                            .foregroundColor(Color("DarkPurple"))
                            .padding(.top)
                }


            }//VStack
            .padding(.top)
        Spacer(minLength: 0)
    }//body
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(model: ModelData())
    }
}

//
//  SignUpView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-16.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var model: ModelData
    @StateObject var authentication = FirebaseAuthentication()
    var fieldValidators = FieldValidators()
    @State var showAlertDialog = false
    @State var errorMessage = ""
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
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
                Text("Create an account with us and start achieving the \nun-achievable")
                    .font(Font.custom("Noteworthy", size: 35).bold())
                    .foregroundColor(Color("PrimaryColor"))
                    .multilineTextAlignment(.center)

            }.padding(.bottom)
        
            VStack(spacing: 20){
                CustomTextField(image: "user", placeholderValue: "Email ID", text: $model.emailSignUp)
                CustomTextField(image: "lock", placeholderValue: "Password", text: $model.passwordSignUp)
                CustomTextField(image: "lock", placeholderValue: "Re-enter Password", text: $model.reEnterPassword)
                Button(action: {
                    errorMessage = fieldValidators.validateSignUp(withEmail: model.emailSignUp, password: model.passwordSignUp, reEnterPassword: model.reEnterPassword)
                    
                    //Perform field validation
                    if  errorMessage != "" {
                        showAlertDialog = true
                    }
                    else{
                        authentication.signUp()
                    }
                }, label: {
                    Text("Sign Up").font(Font.custom("Noteworthy", size: 20).bold())
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color("DarkPurple"))
                        .clipShape(Capsule())
                    
                })
                .padding(.top)
                .alert(isPresented: $showAlertDialog){
                    Alert(title: Text("Sign Up Error"),
                          message: Text(errorMessage),
                          dismissButton: .default(Text("Okay")))
                }
            }.padding(.top)
            
            Spacer(minLength: 0)

        }//VStack
        .padding(.top, 70)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "xmark")
                .foregroundColor(Color("DarkPurple"))
                .padding()
                .background(Color("LightPurple").opacity(0.175))
                .clipShape(Circle())
                .padding(.top, 0.5)
        })
    }//body
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(model: ModelData())
    }
}

//
//  LoginView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-16.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject var model : LoginModel = LoginModel()
//    @StateObject var model : ModelData
    var fieldValidators = FieldValidators()
    @State var errorMessage = ""
    @State var showAlertDialog = false
    //Loading
    @State var isLoading = false
    let dispatchGroup = DispatchGroup()
    //User status
    @AppStorage("log_Status") var userStatus = false
    
    @EnvironmentObject var session: FirebaseAuthentication
    
    var body: some View{
        ZStack {
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
                        CustomTextField(image: "person.fill", placeholderValue: "Email ID", text: $model.emailLogin).disableAutocorrection(true)
                        CustomTextField(image: "lock", placeholderValue: "Password", text: $model.passwordLogin)
                        Button(action: {
                            errorMessage = fieldValidators.validateLogin(withEmail: model.emailLogin, password: model.passwordLogin)
                                
                            if errorMessage != "" {
                                showAlertDialog = true
                            }
                            else{
                                
                                //Start the loading view
                                withAnimation{
                                    self.isLoading.toggle()
                                }
                                
                                //Sign in procedure...
                                session.login(withEmail: model.emailLogin, andPassword: model.passwordLogin) {
                                    (result, error) in
                                    
                                    print("Error login: \(error?.localizedDescription ?? "No Error")")
                                    errorMessage = error?.localizedDescription ?? ""
                                    
                                    //Stop the loading view
                                    withAnimation{
                                        self.isLoading.toggle()
                                    }
                                    
                                    //No error in login
                                    if errorMessage == ""{
                                        let user = result?.user
                                        
                                        //User did not verify email id
                                        if !user!.isEmailVerified{
                                            errorMessage = "Please verify your email before logging in"
                                            showAlertDialog.toggle()
                                            self.userStatus = false
                                            try! Auth.auth().signOut()
                                        }else{
                                            //Set user state as logged in
                                            withAnimation{
                                                self.userStatus = true
                                            }
                                            print("User logged in")
                                        }

                                    }else{
                                        showAlertDialog.toggle()
                                    }
                                }
                                
                                
//                                Auth.auth().signIn(withEmail: model.emailLogin, password: model.passwordLogin) { (result, error) in
//
//                                    print("Error login: \(error?.localizedDescription ?? "No Error")")
//                                    errorMessage = error?.localizedDescription ?? ""
//
//                                    //Stop the loading view
//                                    withAnimation{
//                                        self.isLoading.toggle()
//                                    }
//
//                                    //No error in login
//                                    if errorMessage == ""{
//                                        let user = result?.user
//
//                                        //User did not verify email id
//                                        if !user!.isEmailVerified{
//                                            errorMessage = "Please verify your email before logging in"
//                                            showAlertDialog.toggle()
//                                            self.userStatus = false
//                                            try! Auth.auth().signOut()
//                                        }else{
//                                            //Set user state as logged in
//                                            withAnimation{
//                                                self.userStatus = true
//                                            }
//                                            print("User logged in")
//                                        }
//
//                                    }else{
//                                        showAlertDialog.toggle()
//                                    }
//                                }
                            }
                                }, label: {
                            Text("Login").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 30)
                                .background(Color("DarkPurple"))
                                .clipShape(Capsule())
                            
                        })
                        .padding(.top)
                        .alert(isPresented: $showAlertDialog){
                            Alert(title: Text("Login Error"),
                                  message: Text(errorMessage),
                                  dismissButton: .default(Text("Okay")))
                        }
                    }.padding(.top)
                    
                    HStack(spacing: 12){
                        Text("Don't have an account?")
                            .foregroundColor(Color("PrimaryColor").opacity(0.8))
                        
                        //Set up the action to navigate to Sign up page
                        NavigationLink(destination: SignUpView()){
                                Text("Sign up here")
                                    .foregroundColor(Color("DarkPurple"))
                        }
                        
    //                    //Set up the action to navigate to Sign up page
    //                    NavigationLink(destination: SignUpView(model: model)){
    //                            Text("Sign up here")
    //                                .foregroundColor(Color("DarkPurple"))
    //                    }
                        
                        
    //                    NavigationLink(destination: SignUpView(model: model)){
    //                            Text("Sign up here")
    //                                .foregroundColor(Color("DarkPurple"))
    //                    }
                        
                    }.padding(.top)
                    
                    NavigationLink(destination: ForgotPasswordView()){
                            Text("Forgot Password?")
                                .foregroundColor(Color("DarkPurple"))
                                .padding(.top)
                    }
                    
    //                //Set up the action to navigate to Sign up page
    //                NavigationLink(destination: ForgotPasswordView(model: model)){
    //                        Text("Forgot Password?")
    //                            .foregroundColor(Color("DarkPurple"))
    //                            .padding(.top)
    //                }


                }//VStack
            .padding(.top)
            
            if self.isLoading{
                LoaderView()
            }
            
        }//ZStack
        Spacer(minLength: 0)
    }//body
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

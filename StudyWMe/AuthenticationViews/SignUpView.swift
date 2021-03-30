//
//  SignUpView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-16.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @StateObject var model: SignUpModel = SignUpModel()
    var fieldValidators = FieldValidators()
    @State var showAlertDialog = false
    @State var dialogErrorMessage = ""
    @State var dialogSuccessMessage = ""
    @State var isLogin = false
    @State var alertDialogType: AlertDialogType = .error
    
    enum AlertDialogType {
        case success, error
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View{
        ZStack {
            VStack{
                Image("logo")
                    .padding(.horizontal)
                    .padding(.vertical, 10.0)
                    .background(Color("LightPurple").opacity(0.175))
                    .cornerRadius(30)

                VStack(spacing:35){
                    Text("StudyWMe")
                        .font(Font.custom("Noteworthy", size: 50).bold())
                        .foregroundColor(Color("PrimaryColor"))
                    Text("Create an account with us and start achieving the \nun-achievable")
                        .font(Font.custom("Noteworthy", size: 35).bold())
                        .foregroundColor(Color("PrimaryColor"))
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)

                }.padding(.bottom)
            
                VStack(spacing: 20){
                    CustomTextField(image: "person.fill", placeholderValue: "Email ID", text: $model.emailSignUp)
                    CustomTextField(image: "lock", placeholderValue: "Password", text: $model.passwordSignUp)
                    CustomTextField(image: "lock", placeholderValue: "Re-enter Password", text: $model.reEnterPassword)
                    Button(action: {
                        dialogErrorMessage = fieldValidators.validateSignUp(withEmail: model.emailSignUp, password: model.passwordSignUp, reEnterPassword: model.reEnterPassword)
                        
                        //Perform field validation
                        if  dialogErrorMessage != "" {
                            alertDialogType = .error
                            showAlertDialog.toggle()
                        }
                        else{
                            //Begin the Loading View
                            withAnimation{
                                self.isLogin.toggle()
                            }
                            Auth.auth().createUser(withEmail: model.emailSignUp, password: model.passwordSignUp){ result, error in
                                withAnimation{
                                    self.isLogin.toggle()
                                }
                                dialogErrorMessage = error?.localizedDescription ?? ""
                                
                                //Account was created successfully
                                if dialogErrorMessage == ""{
                                    //Send Verification Email
                                    result?.user.sendEmailVerification(completion: { (error) in
                                        dialogErrorMessage = error?.localizedDescription ?? ""
                                        //Email verification was sent successfully
                                        if dialogErrorMessage == ""{
                                            self.dialogSuccessMessage = "Your account was created successfully. Please verify your email and login to your account."
                                            alertDialogType = .success
                                            self.showAlertDialog.toggle()
                                        }else{
                                            alertDialogType = .error
                                            self.showAlertDialog.toggle()
                                        }
                                        
                                    })
                                }else{
                                    alertDialogType = .error
                                    self.showAlertDialog.toggle()
                                }
                            }
                        }
                    }, label: {
                        Text("Sign Up").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color("DarkPurple"))
                            .clipShape(Capsule())
                        
                    })
                    .padding(.bottom)
                    .alert(isPresented: $showAlertDialog){
                        switch alertDialogType {
                        case .error:
                            return Alert(title: Text("Sign Up Error"),
                                  message: Text(dialogErrorMessage),
                                  dismissButton: .default(Text("Okay")))
                        case .success:
                            return Alert(title: Text("Sign Up Successful"),
                                    message: Text(dialogSuccessMessage),
                                    dismissButton: .default(Text("Okay")){
                                        self.mode.wrappedValue.dismiss()
                                    })
                        }

                    }
//                    .alert(isPresented: $showSuccessAlertDialog){
//                        Alert(title: Text("Sign Up Successful"), message: Text("Your account was created successfuly. Check your email for verification and login with your account."), dismissButton: .default(Text("Okay")))
//                    }
                }
                Spacer(minLength: 0)

            }//VStack
            .padding(.top)
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
            
            if self.isLogin{
                LoaderView()
            }
            
        }
    }//body
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

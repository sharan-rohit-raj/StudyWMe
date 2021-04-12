//
//  ForgotPasswordView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-16.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    enum AlertDialogType{
        case error, success
    }
    @StateObject var model: ForgotPasswordModel = ForgotPasswordModel()
    @StateObject var authentication = FirebaseAuthentication()
    var fieldValidators = FieldValidators()
    @State var showAlertDialog = false
    @State var alertDialogType:AlertDialogType = .error
    @State var errorMessage = ""
    @State var successMessage = ""
    @State var isLoading = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View{
        ZStack {
            VStack{
                Image("logo")
                    .padding(.horizontal)
                    .padding(.vertical, 25.0)
                    .background(Color("LightPurple").opacity(0.175))
                    .cornerRadius(30)
        
                VStack(spacing:35){
                    Text("StudyWMe")
                        .font(Font.custom("Noteworthy", size: 50).bold())
                        .foregroundColor(Color("PrimaryColor"))
                    Text("Forgot your password?\n Don't you worry, we've got it covered.\n Just enter your account email below.")
                        .font(Font.custom("Noteworthy", size: 35).bold())
                        .foregroundColor(Color("PrimaryColor"))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)

                }.padding(.bottom)
            
                VStack(spacing: 20){
                    CustomTextField(image: "envelope.fill", placeholderValue: "Email ID", text: $model.passwordResetEmail)
                    Button(action: {
                        errorMessage = fieldValidators.validateForgotPassword(withEmail: model.passwordResetEmail)
                        
                        if errorMessage != "" {
                            self.alertDialogType = .error
                            showAlertDialog.toggle()
                        }else{
                            withAnimation{
                                self.isLoading.toggle()
                            }
                            //Begin sending password reset email
                            authentication.forgotPassword(email: model.passwordResetEmail) { error in
                                //Stop loading
                                self.isLoading.toggle()
                                
                                errorMessage = error?.localizedDescription ?? ""
                                
                                //Password reset email was sent successfully
                                if errorMessage == "" {
                                    self.alertDialogType = .success
                                    successMessage = "An email has been sent with a password reset link. Please check your email."
                                    self.showAlertDialog.toggle()
                                }
                                //Error sending password reset email
                                else{
                                    self.alertDialogType = .error
                                    self.showAlertDialog.toggle()
                                }
                            }
                        }
                    }, label: {
                        Text("Send Email").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color("DarkPurple"))
                            .clipShape(Capsule())
                        
                    })
                    .alert(isPresented: $showAlertDialog){
                        
                        switch alertDialogType {
                            case .error:
                            return  Alert(title: Text("Forgot Password Error"),
                                        message: Text(errorMessage),
                                        dismissButton: .default(Text("Okay")))
                        case .success:
                            return Alert(title: Text("Success"),
                                         message: Text(successMessage),
                                         dismissButton: .default(Text("Okay")) {
                                            self.mode.wrappedValue.dismiss()
                                         })
                        }
                        

                    }
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
            
            if self.isLoading{
                LoaderView()
            }
            
        
        }//ZStack
    }//body
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}

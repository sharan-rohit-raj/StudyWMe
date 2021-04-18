//
//  DeleteAccountView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-17.
//

import SwiftUI
import FirebaseFirestore

struct DeleteAccountView: View {
    @StateObject var model: DeleteAccountViewModel = DeleteAccountViewModel()
    @ObservedObject var monitor: NetworkMonitor = NetworkMonitor()
    @StateObject var firebaseAuth: FirebaseAuthentication = FirebaseAuthentication()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isLoading = false
    @State var alertType: AlertTypes = .success
    @State var errorMessage: String = ""
    @State var showDialog = false
    private var db = Firestore.firestore()
    
    enum AlertTypes {
        case networkError, fieldsEmpty, success, otherError
    }
    var body: some View {
        
        ZStack {
            VStack (spacing: 120){
                VStack(spacing: 10){
                    Text("We are sad to see you leave :(")
                        .font(Font.custom("Noteworthy", size: 42).bold())
                        .foregroundColor(Color("DarkPurple"))
                    Text("StudyWMe hopes you come back soon...")
                        .font(Font.custom("Noteworthy", size: 35))
                        .foregroundColor(Color("DarkPurple"))
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                .offset(x: 30)
                
                VStack(spacing: 30) {
                    Text("Please re-enter your credentials below")
                        .font(Font.custom("Noteworthy", size: 30))
                        .foregroundColor(Color("DarkPurple"))
                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                        .offset(x: 30)
                    
                    CustomTextField(image: "person.fill", placeholderValue: "Email ID", text: $model.emailID)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    
                    CustomTextField(image: "lock", placeholderValue: "Password", text: $model.password)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding(.top)
                }
                
                HStack(spacing: 60){
                    
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("I don't want to leave").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color("DarkPurple"))
                            .padding(.vertical)
                            .frame(width: 300)
                            .background(Color.yellow)
                            .clipShape(Capsule())
                    })
                    
                    Button(action: {
                        if !monitor.isConnected {
                            self.alertType = .networkError
                            self.showDialog.toggle()
                        }
                        else if model.emailID.isEmpty || model.password.isEmpty {
                            self.alertType = .fieldsEmpty
                            self.showDialog.toggle()
                        }
                        else{
                            performDeleteAccount()
                        }
                    }, label: {
                        Text("Goodbye!").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .frame(width: 300)
                            .background(Color("DarkPurple"))
                            .clipShape(Capsule())
                    })
                    .alert(isPresented: $showDialog, content: {
                        switch(self.alertType) {
                        case .networkError:
                            return Alert(title: Text("Error"), message: Text("Please check if your device is connected to the internet"), dismissButton: .default(Text("Okay")))
                        case .fieldsEmpty:
                            return Alert(title: Text("Error"), message: Text("Please don't leave any fields empty"), dismissButton: .default(Text("Okay")))
                        case .success:
                            return Alert(title: Text("Success"), message: Text("It was nice having you here. Goodluck with all your future endeavours!"), dismissButton: .default(Text("Thanks!")) {
                                self.mode.wrappedValue.dismiss()
                                let _ = self.firebaseAuth.logout()
                            })
                        case .otherError:
                            return Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("Okay")))
                        }
                    })
                }
                .frame(width: UIScreen.main.bounds.width * 0.7)

                
            }//VStack
            
            if self.isLoading{
                LoaderView()
            }
        }//ZStack
    }
    func performDeleteAccount() {
        self.isLoading.toggle()
        firebaseAuth.reAuthenticate(email: model.emailID, password: model.password) { (authDataResult, error) in
            self.errorMessage = error?.localizedDescription ?? ""
            if self.errorMessage == "" {
                //Reauthenticated
                //Delete account details
                self.db.collection("students").document(authDataResult!.user.uid).delete { (error) in
                    self.errorMessage = error?.localizedDescription ?? ""
                    if self.errorMessage == "" {
                        //Account Details Deleted
                        self.isLoading.toggle()
                        self.mode.wrappedValue.dismiss()
                        
                        self.firebaseAuth.deleteAccount { (error) in
                            self.errorMessage = error?.localizedDescription ?? ""
                            if self.errorMessage != ""{
                                //Error while deleting account
                                self.isLoading.toggle()
                                self.alertType = .otherError
                                self.showDialog.toggle()
                            }
                        }
                        

                    }else{
                        //Error while deleting account details
                        self.isLoading.toggle()
                        self.alertType = .otherError
                        self.showDialog.toggle()
                    }
                }
            }
            else{
                //Error while re-authenticating
                self.isLoading.toggle()
                self.alertType = .otherError
                self.showDialog.toggle()
            }
        }//reAuthenticate
    }
}


struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}

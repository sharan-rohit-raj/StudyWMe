//
//  ProfileView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-26.
//

import SwiftUI
import Firebase
import Network

struct ProfileView: View {
    @ObservedObject var model : ProfileModel
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @State var emailID: String = Auth.auth().currentUser?.email ?? ""
    @State var showAlert: Bool = false
    @State var alertType: AlertType = .emptyField
    @State var displayNameError: String = ""
    @State var isLoading = false
    @ObservedObject var monitor = NetworkMonitor()
    @State var tryintoEditEmail: Bool = false
    @State var isDeleteSheetPresented = false
    
    enum AlertType {
        case emptyField, invalidPhoneNumber, noNetwork, errorOccured, successSave, displayNameUpdateError
    }
    

    
    var body: some View {
        
        NavigationView{
            ZStack {
                VStack {
                    VStack(spacing: 30) {
                        Text("Account")
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
                
                    VStack(spacing: 35) {
                        VStack{
                            Text("First name")
                                .font(Font.custom("Noteworthy", size: 25))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                .padding(.bottom)
                            CustomTextField(image: "person.fill", placeholderValue: "First Name", text: $model.firstName)
                                .autocapitalization(UITextAutocapitalizationType.words)
                        }
                        
                        VStack{
                            Text("Last name")
                                .font(Font.custom("Noteworthy", size: 25))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                .padding(.bottom)
                            CustomTextField(image: "person.fill", placeholderValue: "Last Name", text: $model.lastName)
                                .autocapitalization(UITextAutocapitalizationType.words)
                        }
                        VStack{
                            Text("Phone number")
                                .font(Font.custom("Noteworthy", size: 25))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                .padding(.bottom)
                            CustomTextField(image: "phone.fill", placeholderValue: "Phone Number", text: $model.phoneNumber)
                                .autocapitalization(UITextAutocapitalizationType.words)
                        }
                        VStack{
                            Text("Email ID")
                                .font(Font.custom("Noteworthy", size: 25))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                .padding(.bottom)
                            
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                Image(systemName: "envelope.fill")
                                    .resizable()
                                    .frame(width:30, height: 30)
                                    .foregroundColor(Color("DarkPurple"))
                                    .padding(.leading)
                                ZStack{
                                    Text(emailID)
                                }
                                .padding(.horizontal)
                                .frame(width: UIScreen.main.bounds.width * 0.97, height: 60)
                                .foregroundColor(Color("DarkPurple"))
                                .background(Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            .onTapGesture {
                                self.tryintoEditEmail.toggle()
                            }
                            .alert(isPresented: $tryintoEditEmail) {
                                return Alert(title: Text("Note"), message: Text("Cannot edit email field. As of now it's for viewing purposes only."), dismissButton: .default(Text("Okay")))
                            }
                        }



                        
                    }.padding(.top, (UIScreen.main.bounds.height * 0.5) - 540)

                    
                    Button(action: {
                        //Check for validation
                        if !self.monitor.isConnected {
                            alertType = .noNetwork
                            self.showAlert.toggle()
                        }
                        else if model.firstName.isEmpty || model.lastName.isEmpty || model.phoneNumber.isEmpty {
                            alertType = .emptyField
                            self.showAlert.toggle()
                        }
                        else if model.phoneNumber.count < 10 {
                            alertType = .invalidPhoneNumber
                            self.showAlert.toggle()
                        }
                        else {
                            self.isLoading.toggle()
                            if let user = Auth.auth().currentUser {
                                let changeRequest = user.createProfileChangeRequest()
                                changeRequest.displayName = model.firstName
                                
                                changeRequest.commitChanges { error in
                                    displayNameError = error?.localizedDescription ?? ""
                                    
                                    self.isLoading.toggle()
                                    if displayNameError != "" {
                                        alertType = .displayNameUpdateError
                                        self.showAlert.toggle()
                                    }else{
                                        model.addProfileData(userUID: user.uid, firstName: model.firstName, lastName: model.lastName, phoneNumber: model.phoneNumber)
                                        alertType = .successSave
                                        self.showAlert.toggle()
                                    }

                                }

     
                            }else{
                                //Was unable to get the user
                                alertType = .errorOccured
                                self.showAlert.toggle()
                            }

                        }
                        
                        
                    }, label: {
                        Text("Save").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color("DarkPurple"))
                            .clipShape(Capsule())
                    })
                    .padding(.top, 45)
                    .alert(isPresented: $showAlert) {
                        switch(alertType) {
                        case .emptyField:
                            return Alert(title: Text("Error"), message: Text("Please do not leave any fields empty"), dismissButton: .default(Text("Okay")))
                        case .invalidPhoneNumber:
                            return Alert(title: Text("Error"), message: Text("Please enter a valid phone number"), dismissButton: .default(Text("Okay")))
                        case .noNetwork:
                            return Alert(title: Text("No Network"), message: Text("Please make sure your device is connected to the internet."), dismissButton: .default(Text("Okay")))
                        case .errorOccured:
                            return Alert(title: Text("Error"), message: Text("An error occurred while trying to save the data."), dismissButton: .default(Text("Okay")))
                        case .successSave:
                            return Alert(title: Text("Success"), message: Text("Profile information was saved successfully!"), dismissButton: .default(Text("Okay")))
                        case .displayNameUpdateError:
                            return Alert(title: Text("Error"), message: Text(displayNameError), dismissButton: .default(Text("Okay")))
                        }
                    }
                    
                    Button(action: {
                        self.isDeleteSheetPresented.toggle()
                    }, label: {
                        Text("Delete account").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color("DarkPurple"))
                    })
                    .padding(.top, 10)
                    .sheet(isPresented: $isDeleteSheetPresented) {
                        DeleteAccountView()
                    }
                    
                    Spacer()
                }//VStack
                .edgesIgnoringSafeArea(.top)
                .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1))
                
                if self.isLoading {
                    LoaderView()
                }
            }
            

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .onDisappear(perform: {
            monitor.cancelMonitor()
        })
        


    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(model: ProfileModel())
    }
}

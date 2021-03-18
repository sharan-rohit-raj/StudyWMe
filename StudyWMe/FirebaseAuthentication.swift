//
//  FirebaseAuthentication.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-18.
//

import Foundation
import Firebase

class FirebaseAuthentication: ObservableObject{
    
    @Published var alert = false
    @Published var alertMessage = ""
    
    //MARK:- Login Functionality
    func login(withEmail email: String, andPassword password: String){
        Auth.auth().signIn(withEmail: email, password: password){(result, error) in
            //When error occurs during sign in
            if error != nil{
                //Record the error message
                self.alertMessage = error!.localizedDescription
                self.alert.toggle()
                return
            }
        }
    }
    //MARK:- Sign up Functionality
    func signUp(){}
    //MARK:- Forgot password Functionality
    func forgotPassword(){}
}

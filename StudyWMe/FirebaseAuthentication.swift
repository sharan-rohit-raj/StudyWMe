//
//  FirebaseAuthentication.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-18.
//

import Foundation
import Firebase
import SwiftUI

class FirebaseAuthentication: ObservableObject{
    
    //User status
    @AppStorage("log_Status") var userStatus = false
    
    //MARK:- Login Functionality
    func login(withEmail email: String, andPassword password: String) -> String{
        var alertMessage = ""
        print("password: \(password)")
        Auth.auth().signIn(withEmail: email, password: password){(result, error) in
            //When error occurs during sign in
            if error != nil{
                //Record the error message
                alertMessage = error!.localizedDescription
                return
            }
            
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified{
                alertMessage = "Please verify your email before logging in"
                try! Auth.auth().signOut()
                return
            }
            
            //Set user state as logged in
            withAnimation{
                self.userStatus = true
            }
        }
            
        return alertMessage
    }
    //MARK:- Sign up Functionality
    func signUp(){}
    //MARK:- Forgot password Functionality
    func forgotPassword(){}
}

//
//  FirebaseAuthentication.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-18.
//

import Foundation
import Firebase
import SwiftUI
import Combine

class FirebaseAuthentication: ObservableObject{
    
    @Published var didChange = PassthroughSubject<FirebaseAuthentication, Never>()
    @Published var session: Student?{
        didSet{
            self.didChange.send(self)
        }
    }
    @Published var handle: AuthStateDidChangeListenerHandle?
    
    //Listen for state changes
    func listenForChangesInState(){
        handle = Auth.auth().addStateDidChangeListener{ (auth, user) in
            if let student = user {
                //We have an user
                print("Student: \(student)")
                self.session = Student(uid: student.uid, email: student.email ?? "", displayName: student.displayName ?? "", phoneNumber: "", age: "")
            }else{
                //We dont have an user
                self.session = nil
            }
        }
    }
    //MARK:- Login Functionality
    func login(withEmail email: String, andPassword password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    //MARK:- Sign up Functionality
    func signUp(withEmail email: String, andPassword password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    //MARK:- Forgot password Functionality
    func forgotPassword(email: String, handler: @escaping SendPasswordResetCallback){
        Auth.auth().sendPasswordReset(withEmail: email, completion: handler)
    }
    //MARK:- Sign out Functionality
    func logout()-> Bool{
        do{
            try Auth.auth().signOut()
            self.session = nil
            return true
        }
        catch{
            return false
        }
    }
    //MARK:- Reauthenticate account functionality
    func reAuthenticate(email: String, password: String, handler: @escaping AuthDataResultCallback ) {
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: handler)
    }
    //MARK:- Delete account funcionality
    func deleteAccount(handler: @escaping ApplyActionCodeCallback ) {
        Auth.auth().currentUser?.delete(completion: handler)
    }
    //MARK:- Detach the listener
    func unbind(){
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}

//
//  SignUpModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-25.
//

import Foundation
class SignUpModel: ObservableObject{
    //Data for Sign Up View
    @Published var emailSignUp = ""
    @Published var passwordSignUp = ""
    @Published var reEnterPassword = ""
}

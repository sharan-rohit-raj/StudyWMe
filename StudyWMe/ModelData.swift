//
//  ModelData.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-16.
//

import Foundation
import UIKit

class ModelData: ObservableObject{
    //Data for Login View
    @Published var emailLogin = ""
    @Published var passwordLogin = ""
    
    //Data for Sign Up View
    @Published var emailSignUp = ""
    @Published var passwordSignUp = ""
    @Published var reEnterPassword = ""
    
    //Data for forgot password
    @Published var passwordResetEmail = ""

    @Published var isLoginView = false
    @Published var isResetEmailSent = false

}

//
//  DeleteAccountViewModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-17.
//

import Foundation
import Firebase
class DeleteAccountViewModel: ObservableObject {
    @Published var emailID: String = Auth.auth().currentUser?.email ?? ""
    @Published var password: String = ""
}

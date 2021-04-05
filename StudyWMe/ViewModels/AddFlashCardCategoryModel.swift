//
//  AddFlashCardCategoryModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import Foundation
class AddFlashCardCategoryModel: ObservableObject {
    @Published var flashCardCategoryName = ""
    @Published var flashCardTitle: String = ""
    @Published var flashCardDetails: String = ""
}

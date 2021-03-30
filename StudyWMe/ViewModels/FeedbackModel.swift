//
//  FeedbackModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-29.
//

import Foundation
class FeedbackModel: ObservableObject {
    @Published var feedback: String = "" {
        didSet {
            if feedback.count > characterLimit && oldValue.count <= characterLimit {
                feedback = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}

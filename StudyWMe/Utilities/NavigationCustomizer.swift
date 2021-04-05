//
//  NavigationCustomizer.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import Foundation
import SwiftUI

struct NavigationCustomizer: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationCustomizer>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationCustomizer>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

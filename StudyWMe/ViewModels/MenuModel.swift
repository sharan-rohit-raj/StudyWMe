//
//  MenuModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-26.
//

import Foundation

class MenuModel: ObservableObject{
    @Published var selectedMenu = "Home"
    @Published var showDrawer = false
}

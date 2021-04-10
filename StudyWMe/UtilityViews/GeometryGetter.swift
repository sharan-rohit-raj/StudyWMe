//
//  GeometryGetter.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-29.
//

import Foundation
import SwiftUI

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}

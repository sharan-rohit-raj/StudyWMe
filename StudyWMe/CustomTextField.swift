//
//  CustomTextField.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-16.
//

import SwiftUI

struct CustomTextField: View {
    var image: String
    var placeholderValue: String
    @Binding var text: String
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            Image(image)
                .resizable()
                .frame(width:40.0, height: 40.0)
                .clipShape(Circle())
                .padding(.leading)
            ZStack{
                if placeholderValue == "Password" || placeholderValue == "Re-enter Password"{
                    SecureField(placeholderValue, text: $text)
                }else{
                    TextField(placeholderValue, text: $text)
                }
            }
                .padding(.horizontal)
                .padding(.leading,65)
                .frame(height: 60)
            .foregroundColor(Color("DarkPurple"))
            .background(Color("LightPurple").opacity(0.175))
                .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}

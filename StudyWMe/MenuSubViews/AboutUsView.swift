//
//  ContactUsView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-26.
//

import SwiftUI

struct AboutUsView: View {
    @StateObject var model: AboutUsModel = AboutUsModel()
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                VStack {
                    VStack(spacing: 30) {
                        Text("About Us")
                            .font(Font.custom("Noteworthy", size: 35).bold())
                            .foregroundColor(Color("DarkPurple"))
                            .frame(width: geometry.size.width , height: 150, alignment: .bottomLeading)
                            .offset(x: 15, y: 0)
                        Text("Here is a little introduction about what inspired us.")
                            .font(Font.custom("Noteworthy", size: 25).bold())
                            .foregroundColor(Color("DarkPurple"))
                            .frame(width: geometry.size.width , alignment: .bottomLeading)
                            .offset(x: 15, y: 0)
                    }
                    
 
                    TextEditor(text: $model.aboutUs)
                        .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.80)
                        .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color("DarkPurple"), lineWidth: 2))
                        .foregroundColor(Color("DarkPurple"))
                        .font(Font.custom("Noteworthy", size: 22))
                        .lineSpacing(5)
                        .lineLimit(2)
                        .disabled(true)
                        .disableAutocorrection(true)
                        .padding(.top)
                    

                    Spacer()
                }.edgesIgnoringSafeArea(.top)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}

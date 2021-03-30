//
//  FeedbackView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-26.
//

import SwiftUI

struct FeedbackView: View {
    @StateObject var model: FeedbackModel = FeedbackModel(limit: 500)
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    var body: some View {
        NavigationView{
                VStack{
                    
                    VStack(spacing: 30) {
                        Text("Feedback")
                            .font(Font.custom("Noteworthy", size: 35).bold())
                            .foregroundColor(Color("DarkPurple"))
                            .frame(width: UIScreen.main.bounds.width , height: 150, alignment: .bottomLeading)
                            .offset(x: 15, y: 0)
                        Text("Please let us know how we are performing in helping you study.")
                            .font(Font.custom("Noteworthy", size: 25).bold())
                            .foregroundColor(Color("DarkPurple"))
                            .frame(width: UIScreen.main.bounds.width , alignment: .bottomLeading)
                            .offset(x: 15, y: 0)
                    }
                    
                    TextEditor(text: $model.feedback)
                        .frame(width: UIScreen.main.bounds.width * 0.95, height: 300)
                        .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color("DarkPurple"), lineWidth: 2))
                        .foregroundColor(Color("DarkPurple"))
                        .font(Font.custom("Noteworthy", size: 25))
                        .lineSpacing(5)
                        .lineLimit(2)
                        .disableAutocorrection(true)
                        .padding(.top, (UIScreen.main.bounds.height * 0.5) - 430)
                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                    
                    Text("Note: We have set the maximum character limit to 500 characters only.")
                        .frame(width: UIScreen.main.bounds.width , alignment: .bottomLeading)
                        .foregroundColor(Color("DarkPurple"))
                        .offset(x: 20, y: 0)
                    
                    Button(action: {}, label: {
                        Text("Send").font(Font.custom("Noteworthy", size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color("DarkPurple"))
                            .clipShape(Capsule())
                    }).padding(.top, UIScreen.main.bounds.height * 0.1)
                    
                    Spacer()
                }
                .ignoresSafeArea(edges: .top)
                .offset(y: kGuardian.slide).animation(.easeInOut(duration: 1))

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}

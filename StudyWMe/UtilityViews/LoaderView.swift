//
//  LoaderView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-25.
//

import SwiftUI

struct LoaderView: View {
    @State var animation = false
    var body: some View {
        VStack{
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color("DarkPurple"), lineWidth: 8)
                .frame(width: 75, height: 75)
                .rotationEffect(.init(degrees: animation ? 360:0))
                .padding(50)
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4)).ignoresSafeArea(.all, edges: .all)
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)){
                animation.toggle()
            }
        })
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}

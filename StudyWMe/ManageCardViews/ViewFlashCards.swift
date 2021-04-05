//
//  ViewFlashCards.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import SwiftUI

struct ViewFlashCards: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String
    @State var isAddCardSheetShown: Bool = false
    
    //Sample data
    @State var flashCards: [FlashCardModel] = [FlashCardModel(id: 0, title: "What is my name?", details: "Sharan"),
                                               FlashCardModel(id: 1, title: "What do I Study?", details: "Computer Science"),
                                               FlashCardModel(id: 2, title: "Where do I live?", details: "Waterloo"),
                                               FlashCardModel(id: 3, title: "What is my profession?", details: "Developer")]
    //Sample Colors
    var colors: [Color] = [Color("DarkMagenta"), Color("LightOrchid"), Color("DarkPurple"), Color("LightPurple"),
    Color("Peach"), Color("KindaBlue"), Color("Sky"), Color("LightMagenta")]

    
    var body: some View {
        
        VStack {
            HStack{
                Button(action : {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color("DarkPurple"))
                        .padding()
                        .padding(.top, 0.5)
                }
                Spacer()
                Text(title)
                    .font(Font.custom("Noteworthy", size: 50).bold())
                    .foregroundColor(Color("DarkPurple"))
                Spacer()
                Button(action : {
                    self.isAddCardSheetShown.toggle()
                }){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color("DarkPurple"))
                        .padding()
                        .padding(.top, 0.5)
                }
                .sheet(isPresented: $isAddCardSheetShown){
                    AddFlashCardCategoryView(flashCardCat: title, isNewCat: false)
                }
                
            }

            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(flashCards) { flashCard in
                        GeometryReader{ geometry in
                            AFlashCard(title: flashCard.title, details: flashCard.details, color: colors.randomElement()!)
                                .rotation3DEffect(
                                    Angle(degrees: (Double(geometry.frame(in: .global).minX) - 80) / -30),
                                    axis: (x: 0, y: 2.5, z: 0)
                                )
                        }
                        .frame(width: 600, height: 800)
                    }
                }.padding(40)
                Spacer()
            }
            
            Spacer()
        }//VStack
        

    }//body
}

struct ViewFlashCards_Previews: PreviewProvider {
    static var previews: some View {
        ViewFlashCards(title: "Hello")
    }
}

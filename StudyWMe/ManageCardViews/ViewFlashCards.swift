//
//  ViewFlashCards.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import SwiftUI
import Firebase

struct ViewFlashCards: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String
    @State var isAddCardSheetShown: Bool = false
    @State var flashCardCategory: FlashCardCategory
    @ObservedObject var flashCards: FlashCards = FlashCards()
    
//    @State var flashCardsModel: [FlashCardModel] = [FlashCardModel]()
    @State var isAddFlashCatClosed: Bool = false
    
    // Colors
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
                    self.isAddFlashCatClosed = false
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
                    AddFlashCardCategoryView(flashCardCat: $flashCardCategory, isNewCat: false, isAddFlashCatClosed: self.$isAddFlashCatClosed)
                }
                
            }

            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(self.flashCards.flashCards, id: \.flashCardId) { flashCard in
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
        .onAppear(perform: {
            print("View Flash Cards: OnAppear")
            
            self.flashCards.fetchFlashCardsData(studentUID: Auth.auth().currentUser!.uid, flashCardCategoryId: flashCardCategory.flashCardCarId)

        })

    }//body
}

struct ViewFlashCards_Previews: PreviewProvider {
    static var previews: some View {
        ViewFlashCards(title: "Hello", flashCardCategory: FlashCardCategory())
    }
}

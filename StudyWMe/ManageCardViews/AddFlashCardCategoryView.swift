//
//  AddFlashCardCategoryView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import SwiftUI

struct AddFlashCardCategoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var id = 0
    @State var flashCardCat: String
    @State var isNewCat: Bool
    @State var flashCards: [FlashCardModel] = [FlashCardModel]()
    @StateObject var model: AddFlashCardCategoryModel = AddFlashCardCategoryModel()
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    
    
    var body: some View {
        ScrollView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("LightOrchid"), Color.white]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                    .ignoresSafeArea()
                VStack{
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                        ZStack{
                            if isNewCat{
                                TextField("Enter Flash Cards Category", text: $model.flashCardCategoryName)
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .foregroundColor(Color("DarkPurple"))
                                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            }
                            else{
                                Text(flashCardCat)
                                .font(Font.custom("Noteworthy", size: 20))
                                .foregroundColor(Color("DarkPurple"))
                            }

                        }
                            .padding(.horizontal)

                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 60)
                        .background(Color.white)
                            .clipShape(Capsule())
                    }
                    .shadow(color: Color("LightPurple").opacity(0.5), radius: 10, x: 0, y: 10)
                    .padding(.horizontal)
                    .padding(.top, 80)
                        
                    //Flash Card
                    ZStack{
                        VStack{
                            Text("Flash Card Title")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Enter Flash Card Title", text: $model.flashCardTitle)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)

                            Text("Flash Card Details")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                                .padding(.top, 50)

                            TextEditor(text: $model.flashCardDetails)
                                .frame(height: 250)
                                .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color("DarkPurple"), lineWidth: 2))
                                .foregroundColor(Color("DarkPurple"))
                                .font(Font.custom("Noteworthy", size: 25))
                                .lineSpacing(5)
                                .lineLimit(2)
                                .padding(.leading)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                            
                        }

                    }//ZStack
                    .frame(width: 500, height: 600)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("LightPurple"), radius: 10, x: 0, y: 10)
                    .padding(.top, 30)
                    
                    
                    HStack {
                        Button(action: {
                            self.mode.wrappedValue.dismiss()
                        }, label: {
                            Text("Cancel").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color("DarkPurple"))
                                .padding(.vertical)
                                .frame(width: 150)
                                .background(Color.yellow)
                                .clipShape(Capsule())
                        })
                        .shadow(color: Color.yellow.opacity(0.25), radius: 10, x: 0, y: 10)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Add More").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color.white)
                                .padding(.vertical)
                                .frame(width: 150)
                                .background(Color("DarkPurple"))
                                .clipShape(Capsule())
                        })
                        .shadow(color: Color("LightPurple").opacity(0.5), radius: 10, x: 0, y: 10)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Save").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color("DarkPurple"))
                                .padding(.vertical)
                                .frame(width: 150)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .shadow(color: Color("LightPurple").opacity(0.5), radius: 10, x: 0, y: 10)
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }//VStack
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
                .onAppear { self.kGuardian.addObserver() }
                .onDisappear { self.kGuardian.removeObserver() }
            }
        }
    }//body

}

struct AddFlashCardCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddFlashCardCategoryView(flashCardCat: "", isNewCat: true)
    }
}

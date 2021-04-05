//
//  AddQuizCardCategoryView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import SwiftUI

struct AddQuizCardCategoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var id = 0
    @State var quizCardCat: String
    @State var isNewCat: Bool
    @State var quizCards: [QuizCardModel] = [QuizCardModel]()
    @StateObject var model: AddQuizCardCategoryModel = AddQuizCardCategoryModel()
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State var isOptionsPressed:[Bool] = [false, false, false, false]
    
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
                                TextField("Enter Quiz Cards Category", text: $model.quizCardCategoryName)
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .foregroundColor(Color("DarkPurple"))
                                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            }
                            else{
                                Text(quizCardCat)
                                .font(Font.custom("Noteworthy", size: 20))
                                .foregroundColor(Color("DarkPurple"))
                            }

                        }
                            .padding(.horizontal)

                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 60)
                        .background(Color.white)
                            .clipShape(Capsule())
                    }
                    .shadow(color: Color("LightPurple"), radius: 10, x: 0, y: 10)
                    .padding(.horizontal)
                    .padding(.top, 80)
                        
                    //Quiz Card
                    ZStack{
                        VStack{
                            Text("Quiz Card Question")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Enter Quiz Card Question", text: $model.quizCardQuestion)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)

                            Text("Quiz Card Options")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                                .padding(.top, 50)
                            
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Option 1", text: $model.quizCardOptions[0])
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(isOptionsPressed[0] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)
                            .onLongPressGesture(minimumDuration: 1) {
                               isOptionsPressed = [true, false, false, false]
                            }
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Option 2", text: $model.quizCardOptions[1])
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(isOptionsPressed[1] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)
                            .onLongPressGesture(minimumDuration: 1) {
                               isOptionsPressed = [false, true, false, false]
                            }
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Option 3", text: $model.quizCardOptions[2])
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(isOptionsPressed[2] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)
                            .onLongPressGesture(minimumDuration: 1) {
                               isOptionsPressed = [false, false, true, false]
                            }
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Option 4", text: $model.quizCardOptions[3])
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(isOptionsPressed[3] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)
                            .onLongPressGesture(minimumDuration: 0.5) {
                               isOptionsPressed = [false, false, false, true]
                            }
                            Text("Note: Please long press on the correct option till it's color changes to green.")
                                .lineLimit(2)
                                .font(Font.custom("Noteworthy", size: 14).bold())
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                                .padding(.top, 10)
                            
                        }//VStack

                    }//ZStack
                    .frame(width: 500, height: 600)
                    .background(Color.white)
                    .ignoresSafeArea()
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
    }
}

struct AddQuizCardCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuizCardCategoryView(quizCardCat: "", isNewCat: true)
    }
}

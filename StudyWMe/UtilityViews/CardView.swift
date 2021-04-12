//
//  FlashCardView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-28.
//

import SwiftUI
import Firebase

/// A view that displays card for flash card category and quiz card category
struct CardView: View {
    @State var title:String
    @State var image:String
    @State var colors: [Color]
    @State var isFlashCard: Bool
    @State var isSheetPresented: Bool = false
    @State var flashCardCategory: FlashCardCategory
    @State var quizCardCategory: QuizCardCategory
    @State var isLongPressed: Bool = false
    @ObservedObject var manageQuizCardCardCategory: ManageQuizCardCategoryModel = ManageQuizCardCategoryModel()
    @ObservedObject var manageFlashCardCategory: ManageFlashCardCategoryModel = ManageFlashCardCategoryModel()
    @State var studentUID = Auth.auth().currentUser?.uid
    @State var dialogMessage = ""
    @State var showDialog = false
    @State var alertType:AlertType = .successCategoryDelete
    @State var monitor: NetworkMonitor = NetworkMonitor()
    
    enum AlertType {
        case confirmation, successCategoryDelete, error, networkError
    }
    
    func deleteCategory() {
        //Delete the flash card category
        if isFlashCard{
            manageFlashCardCategory.deleteFlashCardCategory(flashCardCategoryID: flashCardCategory.flashCardCarId, studentUID: studentUID!) { error in
                dialogMessage = error?.localizedDescription ?? ""
                
                if dialogMessage == "" {
                    self.alertType = .successCategoryDelete
                    self.showDialog.toggle()
                }else{
                    //Error occured while deleting
                    self.alertType = .error
                    self.showDialog.toggle()
                }
            }
        }
        //Delete the quiz card category
        else{
            manageQuizCardCardCategory.deleteQuizCardCategory(quizCardCategoryID: quizCardCategory.quizCardCatId, studentUID: studentUID!) { error in
                dialogMessage = error?.localizedDescription ?? ""
                
                if dialogMessage == "" {
                    self.alertType = .successCategoryDelete
                    self.showDialog.toggle()
                }else{
                    //Error occured while deleting
                    self.alertType = .error
                    self.showDialog.toggle()
                }
            }
        }
    }
    
    
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 450)
                .blur(radius: 4)
            
            if !self.isLongPressed {
                Text(title)
                    .font(Font.custom("Noteworthy", size: 40)).bold()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
            }else{
                Button(action: {
                    if monitor.isConnected {
                        alertType = .confirmation
                        self.showDialog.toggle()
                    }
                    else{
                        alertType = .networkError
                        self.showDialog.toggle()
                    }

                }, label: {
                    HStack(spacing: 20) {
                        Image(systemName: "trash")
                        .resizable()
                            .foregroundColor(Color.white)
                        .frame(width: 45, height: 45)
                        
                        
                        Text("Delete")
                            .font(Font.custom("Noteworthy", size: 30).bold())
                            .foregroundColor(Color.white)
                            
                    }
                    .frame(width: 200, height: 80)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                })
                .alert(isPresented: $showDialog) {
                    switch(alertType){
                    case .successCategoryDelete:
                        return Alert(title: Text("Success"), message: Text("Category was deleted successfully"), dismissButton: .default(Text("Okay")))
                    case .error:
                        return Alert(title: Text("Error"), message: Text("Error occurred while deleting"), dismissButton: .default(Text("Okay")))
                    case .confirmation:
                        return Alert(title: Text("Confirmation"), message: Text("Are you sure that you wish to delete this category?"), primaryButton: .default(Text("No")) {
                            self.isLongPressed.toggle()
                        }, secondaryButton: .destructive(Text("Yes")) {
                            self.deleteCategory()
                        })
                    case .networkError:
                        return Alert(title: Text("Error"), message: Text("Please check if your device is connected to the internet and try again."), dismissButton: .default(Text("Okay")) {
                            self.isLongPressed.toggle()
                        })
                        
                    }
                }
            }

        }
        .frame(width: 350, height: 450)
        .cornerRadius(25)
        .shadow(color: Color("LightOrchid").opacity(0.75), radius: 10, x: 0, y: 20)
        .onTapGesture {
            if self.isLongPressed{
                self.isLongPressed.toggle()
            }
            isSheetPresented.toggle()
        }
        .onLongPressGesture {
            withAnimation {
                self.isLongPressed.toggle()
            }
        }
        .fullScreenCover(isPresented: $isSheetPresented) {
            if isFlashCard{
                ViewFlashCards.init(title: title, flashCardCategoryId: flashCardCategory.flashCardCarId)
            }else{
                ViewQuizCards.init(title: title, quizCardCategoryID: quizCardCategory.quizCardCatId)
            }
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "iPhone Programming", image: "moonFlashCard", colors: [Color("Grape"), Color("Sky")], isFlashCard: true, flashCardCategory: FlashCardCategory(id: "", flashCardCarId: "", title: "", image: "", flashCards: []), quizCardCategory: QuizCardCategory())
    }
}

//
//  CardReminder.swift
//  CBro
//
//  Created by Gregorius Yuristama Nugraha on 25/03/23.
//

import SwiftUI

struct CardReminder: View {
    let reminderTitle: String
    let reminderTime: Date
    let idxQuote: Int
    let idxImage: Int
    
    var body: some View {
        HStack {
            VStack{
                HStack{
                    Text("\(reminderTitle)")
//                        .padding(.horizontal, 20)
//                        .padding(.top, 15)
                        .foregroundColor(.black)
                        .bold()
                        .font(.title2)
                    Spacer()
        
                }
                HStack{
                    Text("\(kListMotivationText[getRandomQuotes(currentIndex: idxQuote)])")
                        .foregroundColor(.black)
//                        .padding(.bottom, 40)
//                        .padding(.horizontal, 20)
                        .font(.body)
                    Spacer()
                }
                Spacer()
                Spacer()
                HStack{
                    Text("\(reminderTime.formatted())")
                        .foregroundColor(.gray)
//                        .padding(.horizontal, 20)
//                        .padding(.bottom, 20)
                        .font(.body)
                    Spacer()
                }
            }
            .padding()
            kCapyCardIcon[getRandomImage(currentIndex: idxImage)]
                .padding(.trailing, 15)
        }
//        .frame(height: 112)
        .background(Color(.white))
        .cornerRadius(16)
        .padding(.bottom, 8)
    }
    func getRandomImage(currentIndex: Int) -> Int{
        return currentIndex % kCapyCardIcon.count
    }
    func getRandomQuotes(currentIndex: Int) -> Int{
        return currentIndex % kListMotivationText.count
    }
}

struct CardReminder_Previews: PreviewProvider {
    static var previews: some View {
        CardReminder(reminderTitle: "Reminder Title", reminderTime: Date(), idxQuote: 0, idxImage: 0)
    }
}

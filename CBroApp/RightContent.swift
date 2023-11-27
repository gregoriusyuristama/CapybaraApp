//
//  RightContent.swift
//  CBro
//
//  Created by Gregorius Yuristama Nugraha on 25/03/23.
//

import SwiftUI
import EventKit

struct RightContent: View {
    @Binding var reminders: [EKReminder]
//    let currentDate = Date()
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("\(Date.getTodayName())")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("\(Date.getCurrentDate())")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Spacer()
            }
            .padding(.leading, 12)
            .padding(.top, 20)
                if reminders.isEmpty{
                    Image("empty agendas")
                        .resizable()
                        .frame(width: 320, height: 310)
                        .aspectRatio(contentMode: .fit)
//                        .padding(.top, 50)
                } else {
                    List{
                        ForEach(reminders.indices, id: \.self){ index in
                            CardReminder(reminderTitle: reminders[index].title, reminderTime: (reminders[index].dueDateComponents?.date)!, idxQuote: index, idxImage: index)
                        }
                    }
                    .padding(.leading, -8)
            }
            
        }.background(Color("coklat"))
            .scrollContentBackground(.hidden)
    }
}

struct RightContent_Previews: PreviewProvider {
    static var previews: some View {
        RightContent(reminders: .constant([]))
    }
}

extension Date {
    static func getTodayName() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayName = dateFormatter.string(from: date)

        return dayName
    }
    static func getCurrentDate() -> String{
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: date)

        return dateString
    }
    
    static func getReminderTime(dueDate: Date) -> String {
    //    let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let timeFormatted = dateFormatter.string(from: dueDate)

        return timeFormatted // prints the current day name as a string
    }
}

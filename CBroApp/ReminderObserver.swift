//
//  ReminderObserver.swift
//  CBro
//
//  Created by Gregorius Yuristama Nugraha on 12/7/23.
//

import Foundation
import EventKit
import Combine

class ReminderObserver: ObservableObject {
    @Published var reminders: [EKReminder] = []
    private var cancellable: AnyCancellable?
    
    init() {
        requestAccess()
    }
    
    func requestAccess() {
        if #available(macOS 14.0, *) {
            EventStoreSingleton.shared.requestFullAccessToReminders { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        self.fetchReminders()
                        self.addReminderObserver()
                        print("Access to reminders granted.")
                    } else {
                        print("Access to reminders denied.")
                    }
                }
            }
        }else {
            //put the old code here so it’s been working in earlier versions before iOS 17.
            EventStoreSingleton.shared.requestAccess(to: .reminder) { granted, error in
                if granted {
                    self.fetchReminders()
                    self.addReminderObserver()
                    print("Access to reminders granted.")
                } else {
                    print("Access to reminders denied.")
                }
            }
        }
        
    }
    
    func addReminderObserver() {
        cancellable = NotificationCenter.default.publisher(for: .EKEventStoreChanged, object: nil)
            .sink { _ in
                self.fetchReminders()
            }
    }
    
    func fetchReminders() {
        let eventStore = EventStoreSingleton.shared
        switch EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized, .fullAccess, .writeOnly:
            let predicate = eventStore.predicateForIncompleteReminders(withDueDateStarting: Date(), ending: Calendar.current.date(byAdding: .init(day: 1), to: Date()), calendars: nil)
            eventStore.fetchReminders(matching: predicate) { reminders in
                
                if let reminders = reminders {
                    let sortedReminders = reminders.sorted { $0.dueDateComponents?.date ?? Date.distantPast < $1.dueDateComponents?.date ?? Date.distantPast}
                    
                    DispatchQueue.main.async {
                        self.reminders = sortedReminders 
                    }
                }
            }
        case .denied, .restricted:
            print("Access to reminders denied or restricted.")
        case .notDetermined:
            print("Access to reminders not determined.")
        @unknown default:
            break
        }
    }
}

class EventStoreSingleton {
    public static var shared = EKEventStore()
}

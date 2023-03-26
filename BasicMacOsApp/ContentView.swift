//
//  ContentView.swift
//  BasicMacOsApp
//
//  Created by Gregorius Yuristama Nugraha on 16/03/23.
//

import SwiftUI
import EventKit
import Combine

var timer = Timer.publish(every: 12, on: .main, in: .common).autoconnect()
var movableWindow: MovingWindow = MovingWindow()

struct ContentView: View {
    @State private var reminders: [EKReminder] = []
    @State private var showFloat: Bool = false
    @State private var controller: MyWindowController? = nil
    
    var body: some View {
        HStack{
            LeftContent(showFloat: $showFloat)
            RightContent(reminders: $reminders)
        }
        .background(Color("coklat"))
        .frame(width: 618, height: 428)
        .onChange(of: showFloat) { showed in
            if showed {
                if controller == nil {
                     controller = MyWindowController(reminders: reminders)
                 }
                 controller?.showWindow(nil)
              
//                openMyWindow(windowRef: movableWindow)
                }
            else {
                if let controller = controller {
                    controller.close()
                    controller.window = nil // Set the window property to nil
                    self.controller = nil
                }
            }
            }
            .onAppear(){
            let eventStore = EKEventStore()

            eventStore.requestAccess(to: .reminder) { granted, error in
                if granted {
                    let predicate = eventStore.predicateForIncompleteReminders(withDueDateStarting: Date(), ending: Calendar.current.date(byAdding: .day, value: 1, to: Date()), calendars: nil)
                    
                    
                    eventStore.fetchReminders(matching: predicate) { fetchedReminders in
                        let sortedReminders = fetchedReminders?.sorted(by: { $0.dueDateComponents?.date ?? Date.distantPast < $1.dueDateComponents?.date ?? Date.distantPast })
                        reminders = sortedReminders ?? []
//                        reminders = []
                    }

                } else {
//                    reminders = []
                }
            }
        }
        
        
    }
    
//    func openMyWindow(windowRef: MovingWindow)
//    {
//
//        let positionPublisher: CurrentValueSubject<Int,Never> = CurrentValueSubject(0)
//        let isMovingPublisher: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
//        
//        
//        windowRef.level = .floating
//        windowRef.hasShadow = false
//        windowRef.backgroundColor = .clear
//        windowRef.isMovableByWindowBackground = true
//        windowRef.titlebarAppearsTransparent = true
//        windowRef.standardWindowButton(.closeButton)?.isHidden = true
//        windowRef.standardWindowButton(.miniaturizeButton)?.isHidden = true
//        windowRef.titleVisibility = .hidden
//        
//        var posX: Double = 0
//        var posY: Double = 0
//        windowRef.standardWindowButton(.zoomButton)?.isHidden = true
////        let reminderTime = reminders[reminders.count-1].dueDateComponents?.date
//        let floatWindow = reminders.isEmpty
//        ? FloatingWindow(positionPublisher: positionPublisher, isMovingPublisher: isMovingPublisher, reminderTitle: "Add new reminder", reminderTime: "Reminders App")
//        : FloatingWindow(positionPublisher: positionPublisher, isMovingPublisher:  isMovingPublisher, reminderTitle: reminders[0].title, reminderTime: Date.getReminderTime(dueDate: (reminders[0].dueDateComponents?.date)!))
//        
//        windowRef.contentView = NSHostingView(rootView: floatWindow
//            .onReceive(timer){ time in
//                let nextPosition = randPosition(currentX: posX, currentY: posY, positionPublisher: positionPublisher)
//
//                
//                let xDifference = nextPosition.x - posX
//                let yDifference = nextPosition.y - posY
//                positionPublisher.send(Int(xDifference))
//                
//                posX = nextPosition.x
//                posY = nextPosition.y
//                
//                let distance = sqrt(pow((xDifference), 2.0) + pow((yDifference), 2.0))
//                windowRef.animateTime = distance/80
//                
//                
//                var isMoving = false
//                
//                if !isMoving{
//                    isMoving = true
//                    isMovingPublisher.send(isMoving)
//                    NSAnimationContext.runAnimationGroup({ context in
//                        context.duration = distance/80
//                        context.allowsImplicitAnimation = true
//                        windowRef.setFrame(.init(origin: nextPosition, size: CGSize(width: 500, height: 500)), display: true)
//                    }, completionHandler: {
//                        isMoving = false
//                        isMovingPublisher.send(isMoving)
//                    })
//                }
//                
//            }
//                                              
//        )
//        windowRef.makeKeyAndOrderFront(nil)
//
//        }
//
//
//    func randPosition(currentX: Double, currentY: Double, positionPublisher: CurrentValueSubject<Int, Never>) -> CGPoint {
//        var pos: CGPoint{
//                guard let screen = NSScreen.main?.visibleFrame.size else{
//                    return .zero
//                }
//
//            let posX = CGFloat.random(in: 0...screen.width - 500)
//            let posY = CGFloat.random(in: 0...screen.height - 500)
//            
//            return .init(x: posX, y: posY)
//            }
//        return pos
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension HorizontalAlignment {
    enum Custom: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[HorizontalAlignment.center]
        }
    }
    static let custom = HorizontalAlignment(Custom.self)
}
extension VerticalAlignment {
    enum Custom: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[VerticalAlignment.center]
        }
    }
    static let custom = VerticalAlignment(Custom.self)
}
extension Alignment {
    static let custom = Alignment(horizontal: .custom,
                                  vertical: .custom)
}

class MyWindowController: NSWindowController {
    convenience init(reminders: [EKReminder]) {
        movableWindow = MovingWindow(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 500),
            styleMask: [.resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        let positionPublisher: CurrentValueSubject<Int,Never> = CurrentValueSubject(0)
        let isMovingPublisher: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
        
        
        movableWindow.level = .floating
        movableWindow.hasShadow = false
        movableWindow.backgroundColor = .clear
        movableWindow.isMovableByWindowBackground = true
        movableWindow.titlebarAppearsTransparent = true
        movableWindow.standardWindowButton(.closeButton)?.isHidden = true
        movableWindow.standardWindowButton(.miniaturizeButton)?.isHidden = true
        movableWindow.titleVisibility = .hidden
        
        var posX: Double = 0
        var posY: Double = 0
        movableWindow.standardWindowButton(.zoomButton)?.isHidden = true
//        let reminderTime = reminders[reminders.count-1].dueDateComponents?.date
        let floatWindow = reminders.isEmpty
        ? FloatingWindow(positionPublisher: positionPublisher, isMovingPublisher: isMovingPublisher, reminderTitle: "Add new reminder", reminderTime: "Reminders App")
        : FloatingWindow(positionPublisher: positionPublisher, isMovingPublisher:  isMovingPublisher, reminderTitle: reminders[0].title, reminderTime: Date.getReminderTime(dueDate: (reminders[0].dueDateComponents?.date)!))
        self.init(window: movableWindow)
        movableWindow.contentView = NSHostingView(rootView: floatWindow
            .onReceive(timer){ time in
                let nextPosition = randPosition(currentX: posX, currentY: posY, positionPublisher: positionPublisher)

                
                let xDifference = nextPosition.x - posX
                let yDifference = nextPosition.y - posY
                positionPublisher.send(Int(xDifference))
                
                posX = nextPosition.x
                posY = nextPosition.y
                
                let distance = sqrt(pow((xDifference), 2.0) + pow((yDifference), 2.0))
                movableWindow.animateTime = distance/80
                
                
                var isMoving = false
                
                if !isMoving{
                    isMoving = true
                    isMovingPublisher.send(isMoving)
                    NSAnimationContext.runAnimationGroup({ context in
                        context.duration = distance/80
                        context.allowsImplicitAnimation = true
                        movableWindow.setFrame(.init(origin: nextPosition, size: CGSize(width: 500, height: 500)), display: true)
                    }, completionHandler: {
                        isMoving = false
                        isMovingPublisher.send(isMoving)
                    })
                }
                
            }
                                              
        )
        movableWindow.makeKeyAndOrderFront(nil)
    }

}

func randPosition(currentX: Double, currentY: Double, positionPublisher: CurrentValueSubject<Int, Never>) -> CGPoint {
    var pos: CGPoint{
            guard let screen = NSScreen.main?.visibleFrame.size else{
                return .zero
            }

        let posX = CGFloat.random(in: 0...screen.width - 500)
        let posY = CGFloat.random(in: 0...screen.height - 500)
        
        return .init(x: posX, y: posY)
        }
    return pos
}

class MovingWindow: NSWindow{
    var animateTime: TimeInterval = 1
    
    override func animationResizeTime(_ newFrame: NSRect) -> TimeInterval {
        return animateTime
    }
    
    
}



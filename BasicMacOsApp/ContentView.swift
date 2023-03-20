//
//  ContentView.swift
//  BasicMacOsApp
//
//  Created by Gregorius Yuristama Nugraha on 16/03/23.
//

import SwiftUI
var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
var duckWindow: DuckWindow = DuckWindow(
    contentRect: NSRect(x: 0, y: 0, width: 200, height: 200),
    styleMask: [.resizable, .fullSizeContentView],
    backing: .buffered, defer: false
)
struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Hello, Icho 👋 !")
            Button("Open Duck") {
                duckWindow = DuckWindow(
                    contentRect: NSRect(x: 0, y: 0, width: 200, height: 200),
                    styleMask: [.resizable, .fullSizeContentView],
                    backing: .buffered, defer: false)
//                let concurrentQueue = DispatchQueue.global(qos: .background)
                openMyWindow(windowRef: duckWindow)
            }
            Button("Close Duck"){
                duckWindow.close()
            }
//            Button("Play Duck"){
//                timer = Timer.TimerPublisher(interval: 1, runLoop: .main, mode: .common).autoconnect()
//            }
//            Button("Stop Duck"){
//                timer.upstream.connect().cancel()
//            }
        }
        .frame(width: 200, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func openMyWindow(windowRef: DuckWindow)
{
    


//    var windowRef: DuckWindow = DuckWindow(
//        contentRect: NSRect(x: 0, y: 0, width: 200, height: 200),
//        styleMask: [.resizable, .fullSizeContentView],
//        backing: .buffered, defer: false)
//    let windowResize = NSDictionary(coder: <#T##NSCoder#>)
    
//    [NSDictionary dictionaryWithObjectsAndKeys: window, NSViewAnimationTargetKey, [NSValue valueWithRect: myNewFrame], NSViewAnimationEndFrameKey, nil];
//    NSArray* animations = [NSArray arrayWithObjects:windowResize, nil];
//    NSViewAnimation* animation = [[NSViewAnimation alloc] initWithViewAnimations: animations];

    
    windowRef.level = .floating
    windowRef.hasShadow = false
    windowRef.backgroundColor = .clear
    windowRef.isMovableByWindowBackground = true
    windowRef.titlebarAppearsTransparent = true
    windowRef.standardWindowButton(.closeButton)?.isHidden = true
    windowRef.standardWindowButton(.miniaturizeButton)?.isHidden = true
    windowRef.titleVisibility = .hidden
    
    var posX: Double = 0
    var posY: Double = 0
    windowRef.standardWindowButton(.zoomButton)?.isHidden = true
    windowRef.contentView = NSHostingView(rootView: FloatingWindow()
        .onReceive(timer){ time in
            
            let nextPosition = randPosition(currentX: posX, currentY: posY)
            let distance = sqrt(pow((nextPosition.x - posX), 2.0) + pow((nextPosition.y - posY), 2.0))
            posX = nextPosition.x
            posY = nextPosition.y
//            print(time)
            windowRef.animateTime = distance/100
            windowRef.setFrame(.init(origin: nextPosition, size: CGSize(width: 200, height: 200)), display: true, animate: true)
        })
    
    windowRef.makeKeyAndOrderFront(nil)
    
//    var timer = Timer(timeInterval: 5, repeats: true){_ in
////        while true{
////            if !isMoving{
////                isMoving = true
////                windowRef.setFrame(.init(origin: randPosition(), size: CGSize(width: 200, height: 200)), display: true, animate: true)
////
////                isMoving = false
////            }
//
////        }
//    }
    

    
    
//    DispatchQueue.global().async {
//
//    }
    
    }


func randPosition(currentX: Double, currentY: Double) -> CGPoint {
    var pos: CGPoint{
            guard let screen = NSScreen.main?.visibleFrame.size else{
                return .zero
            }

        let posX = CGFloat.random(in: 0...screen.width - 160)
        let posY = CGFloat.random(in: 0...screen.height - 147)
//        print(posX)
//        print(posY)
        return .init(x: posX, y: posY)
        }
    return pos
}


class DuckWindow: NSWindow{
    var animateTime: TimeInterval = 1
    
    
    override func animationResizeTime(_ newFrame: NSRect) -> TimeInterval {
        return animateTime
    }
}


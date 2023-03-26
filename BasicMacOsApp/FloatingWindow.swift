//
//  FloatingWindow.swift
//  BasicMacOsApp
//
//  Created by Gregorius Yuristama Nugraha on 16/03/23.
//

import SwiftUI
import AppKit
import Combine

struct FloatingWindow: View {
    @State var imageSequence: [NSImage] = kIdleImageArray
    var positionPublisher: CurrentValueSubject<Int,Never>
    var isMovingPublisher: CurrentValueSubject<Bool, Never>
    var reminderTitle: String
    var reminderTime: String
    @State var animatedWindow = AnimatedAnimalView(movingToLeft: true, isMoving: false, reminderTitle: "Test", reminderTime: "1.00")
    
    var body: some View {
        animatedWindow
        .onReceive(isMovingPublisher) { output in
            animatedWindow.isMoving = output
        }
        .onReceive(positionPublisher) { output in
            if output < 0 {
                animatedWindow.movingToLeft = true
                
            } else {
                animatedWindow.movingToLeft = false
            }
        }
        .onAppear{
            animatedWindow.reminderTitle = reminderTitle
            animatedWindow.reminderTime = reminderTime
        }
    }
}
struct FloatingWindow_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedAnimalView(movingToLeft: false, isMoving: false, reminderTitle: "Test", reminderTime: "01:00")
        .frame(width: 500, height: 500)
    }
}


struct AnimatedAnimalView: NSViewRepresentable{
    @State var imageSequence: [NSImage]?
    var movingToLeft: Bool
    var isMoving: Bool
    var reminderTitle: String
    var reminderTime: String
    
    func makeNSView(context: Context) -> NSAnimatedAnimalView {
        let view = NSAnimatedAnimalView()
        return view
    }
    
    
    func updateNSView(_ nsView: NSAnimatedAnimalView, context: Context) {
//        print("Update UI")
//        print(isMoving)
        nsView.layer?.sublayers?.removeAll()
        nsView.subviews.removeAll()
        
        if isMoving{
            if movingToLeft {
                nsView.layer?.addSublayer(walkingAnimation(imageSequence: kImageSequenceWindow))
//                nsView.subviews.append(showBubbleChat(reminderText: reminderTitle, reminderTime: reminderTime, toLeft: true))
                
            } else {
    //            nsView.layer?.sublayers?.last?.removeFromSuperlayer()
                nsView.layer?.addSublayer(walkingAnimation(imageSequence: kInvertedImageSequenceWindow))
//                nsView.subviews.append(showBubbleChat(reminderText: reminderTitle, reminderTime: reminderTime, toLeft: false))
            }
        } else {
            nsView.layer?.addSublayer(walkingAnimation(imageSequence: kIdleImageArray))
            nsView.subviews.append(showBubbleChat(reminderText: reminderTitle, reminderTime: reminderTime, toLeft: true))
        }
        
    }
    
    func walkingAnimation(imageSequence: [NSImage]) -> CALayer {
        let keyPath = "contents" // (I did not find a constant for that key.)
        let frameAnimation = CAKeyframeAnimation(keyPath: keyPath)
        frameAnimation.calculationMode = CAAnimationCalculationMode.discrete

        let durationOfAnimation: CFTimeInterval = 1.5
        frameAnimation.duration = durationOfAnimation
        frameAnimation.repeatCount = .infinity
        
        frameAnimation.values = imageSequence

        let imageView = NSImageView()
        imageView.wantsLayer = true
        imageView.setFrameSize(NSSize(width: 230, height: 198))
        imageView.setFrameOrigin(CGPoint(x: 0, y: 0))
        imageView.layer = CALayer()

        let layer = CALayer()
        let layerRect = CGRect(origin: CGPoint.zero, size: imageView.frame.size)
        layer.frame = layerRect
        layer.bounds = layerRect
        layer.add(frameAnimation, forKey: keyPath)
        
        return layer
    }
    typealias NSViewType = NSAnimatedAnimalView
    

}

func showBubbleChat(reminderText: String, reminderTime: String, toLeft: Bool) -> NSImageView{
    
    var chatImage = NSImage()
    
    if toLeft{
        chatImage = NSImage(named: "Bubble Chat_Left")!
    } else{
        chatImage = NSImage(named: "Bubble Chat_Right")!
    }
    
    let chatImageView = NSImageView(image: chatImage)
    chatImageView.wantsLayer = true
    chatImageView.setFrameSize(NSSize(width: 236, height: 248))
    chatImageView.setFrameOrigin(CGPoint(x: 0, y: 180))


    let stackView = NSStackView()
    
    let label = NSTextField()
    label.frame = NSRect(x: 0, y: 0, width: 200, height: 200)
    var bubbleChatString = "Hey 👋"
    var attributedString = NSMutableAttributedString(string: bubbleChatString)
    
    let boldFontAttribute = [NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 22)]
    let regFontAttribute = [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 22)]
    
    let isShowingReminder = Bool.random()
    
    if isShowingReminder {
        bubbleChatString += "\n\nDon't forget to\n\n\(reminderText)\nat \(reminderTime)"
        
        attributedString = NSMutableAttributedString(string: bubbleChatString)
        
        let rangeReminderText = (bubbleChatString as NSString).range(of: "\(reminderText)")
        
        let rangeReminderTime = (bubbleChatString as NSString).range(of: "\(reminderTime)")
        
        let rangeDontForget = (bubbleChatString as NSString).range(of: "Don't forget to")
        let rangeAt = (bubbleChatString as NSString).range(of: "at")
        
        attributedString.addAttributes(boldFontAttribute, range: rangeReminderText)
        attributedString.addAttributes(boldFontAttribute, range: rangeReminderTime)
        attributedString.addAttributes(regFontAttribute, range: rangeDontForget)
        attributedString.addAttributes(regFontAttribute, range: rangeAt)
        
    } else {
        
        let quotes = kCapyQuotes.randomElement()!
        print(quotes)
        bubbleChatString += "\n\n\(quotes)"
        
        attributedString = NSMutableAttributedString(string: bubbleChatString)
        
        let rangeQuotes = (bubbleChatString as NSString).range(of: quotes)
        
        attributedString.addAttributes(regFontAttribute, range: rangeQuotes)
        
    }
    let heyRange = (bubbleChatString as NSString).range(of: "Hey 👋")
    attributedString.addAttributes(boldFontAttribute, range: heyRange)
    
    label.attributedStringValue = attributedString
    
    label.backgroundColor = .clear
    label.textColor = .black
    label.isBezeled = false
    label.isEditable = false

    label.setFrameOrigin(CGPoint(x: ((chatImageView.layer?.frame.width)! - label.frame.width)/2, y: ((chatImageView.layer?.frame.height)! - label.frame.height)/2))
    
    let posAnimation = CABasicAnimation(keyPath: "position")
    if toLeft {
        posAnimation.fromValue = NSValue(point: CGPoint(x: 500, y: 100))
        posAnimation.toValue = NSValue(point: CGPoint(x: 10, y: 180))
    } else {
        posAnimation.fromValue = NSValue(point: CGPoint(x: -500, y: 100))
        posAnimation.toValue = NSValue(point: CGPoint(x: 100, y: 180))
    }
    posAnimation.duration = 0.3
    posAnimation.isRemovedOnCompletion = false
    posAnimation.fillMode = CAMediaTimingFillMode.forwards
    posAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//    posAnimation.repeatCount = .infinity
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.fromValue = 0.0
    scaleAnimation.toValue = 1.0
    scaleAnimation.duration = 0.5
    
    let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
    opacityAnimation.fromValue = 0.0
    opacityAnimation.toValue = 1.0
    opacityAnimation.duration = 0.5
    
    let groupAnimation = CAAnimationGroup()
    groupAnimation.animations = [scaleAnimation, opacityAnimation, posAnimation]
    groupAnimation.duration = 15
    groupAnimation.repeatCount = .greatestFiniteMagnitude
    groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    
    chatImageView.layer?.add(groupAnimation, forKey: "bubbleChat")
    
//    let label2 = NSTextField()
//    label2.frame = NSRect(x: 0, y: 0, width: 150, height: 100)
//    label2.stringValue = "Don't Forget to"
//    label2.backgroundColor = .clear
//    label2.textColor = .black
//    label2.isBezeled = false
//    label2.isEditable = false
//    label2.setFrameOrigin(CGPoint(x: ((chatImageView.layer?.frame.width)! - label2.frame.width)/2, y: ((chatImageView.layer?.frame.height)! - label2.frame.height)/2 - 10))
//
//    let label3 = NSTextField()
//    label3.frame = NSRect(x: 0, y: 0, width: 150, height: 100)
//    label3.stringValue = "\(reminderText)"
//    label3.backgroundColor = .clear
//    label3.textColor = .black
//    label3.font = .boldSystemFont(ofSize: 12)
//    label3.isBezeled = false
//    label3.isEditable = false
//    label3.setFrameOrigin(CGPoint(x: ((chatImageView.layer?.frame.width)! - label3.frame.width)/2, y: ((chatImageView.layer?.frame.height)! - label3.frame.height)/2-40))
//
//    let label4 = NSTextField()
//
//    let myString = "At \(reminderTime)"
//    let attributedString = NSMutableAttributedString(string: myString)
//
//    let boldFontAttribute = [NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 12)]
//    let range = (myString as NSString).range(of: "\(reminderTime)")
//
//    attributedString.addAttributes(boldFontAttribute, range: range)
//    label4.frame = NSRect(x: 0, y: 0, width: 150, height: 100)
//    label4.attributedStringValue = attributedString
//    label4.backgroundColor = .clear
//    label4.textColor = .black
//    label4.isBezeled = false
//    label4.isEditable = false
//    label4.setFrameOrigin(CGPoint(x: ((chatImageView.layer?.frame.width)! - label4.frame.width)/2, y: ((chatImageView.layer?.frame.height)! - label4.frame.height)/2-60))
//
//    stackView.addSubview(label4)
//    stackView.addSubview(label3)
//    stackView.addSubview(label2)
    stackView.addSubview(label)
    
    chatImageView.addSubview(stackView)
    
    
    return chatImageView
}



class NSAnimatedAnimalView: NSView {

    init(){
        
        super.init(frame: NSScreen.main!.frame)
        
        self.wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    
}


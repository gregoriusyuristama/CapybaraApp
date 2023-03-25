//
//  ContentView.swift
//  CBroHome
//
//  Created by Jessica Rachel on 21/03/23.
//

import EventKit
import SwiftUI

struct CBroHome: View {
    var body: some View {
        HStack{
            HStack {
                HStack {
                    VStack {
                        ZStack (alignment: .custom){
                            Image("bubble")
                                .resizable()
                                .scaledToFit()
                            
                            VStack {
                                Text("Hello 👋 !")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.leading, -99)
                                    .padding(.bottom, 5)
                                    .padding (.top, -125)
                                    .foregroundColor(.black)
                                    .frame(width: 230)
                                
                                Text("I Have Something to say you today:")
                                    .fontWeight(.regular)
                                    .font(.system(size: 17))
                                    .padding(.bottom, 5)
                                    .padding(.leading, -20)
                                    .padding(.top, -80)
                                    .foregroundColor(.black)
                                    .frame(width: 230)
                                
                                Text("Be the largest rodent your field, and to strive measure up to your full potential.")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                    .padding(.top, -20)
                                    .fontWeight(.heavy)
                                    .frame(width: 230)
                            }
                            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                                Text("Release Me")
                                    .foregroundColor(.black)
                            }  .toggleStyle(.switch)
                            
                            .alignmentGuide(HorizontalAlignment.custom)
                            { d in d[.trailing] * -0.1}
                            .alignmentGuide(VerticalAlignment.custom)
                            { d in d[.bottom] * -8.6}
                        }
                        
                    }
                }
                
            }  .padding()
                .frame(width: 270, height: 440)
                .background(Color("tosca"))
            VStack{
                List{
                    VStack{
                        Text("Monday")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("20 Mar 2023")
                            .foregroundColor(.white)
                            .padding(.leading, -20)
                    }
                    HStack {
                        VStack{
                            HStack{
                                Text("Event")
                                    .padding(.horizontal, 20)
                                    .padding(.top, 15)
                                    .foregroundColor(.black)
                                Spacer()
                                
                                
                                
                            }
                            HStack{
                                Text("Subtitle")
                                    .foregroundColor(.black)
                                    .padding(.bottom, 40)
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                            HStack{
                                Text("Time")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 20)
                                Spacer()
                            }
                        }
                        Image ("capybaraFlower")
                            .padding(.trailing, 2)
                    } .background(Color(.white))
                        .cornerRadius(8)
                    HStack {
                        VStack{
                            HStack{
                                Text("Event")
                                    .padding(.horizontal, 20)
                                    .padding(.top, 15)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            HStack{
                                Text("Subtitle")
                                    .foregroundColor(.black)
                                    .padding(.bottom, 40)
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                            HStack{
                                Text("Time")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 20)
                                Spacer()
                            }
                        }
                        Image ("capybaraWoke")
                            .padding(.trailing, 10)
                    } .background(Color(.white))
                        .cornerRadius(8)
                    HStack {
                        VStack{
                            HStack{
                                Text("Event")
                                    .padding(.horizontal, 20)
                                    .padding(.top, 15)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            HStack{
                                Text("Subtitle")
                                    .foregroundColor(.black)
                                    .padding(.bottom, 40)
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                            HStack{
                                Text("Time")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 20)
                                Spacer()
                            }
                        }
                        Image ("capybaraWork")
                            .padding(.trailing, 5)
                    } .background(Color(.white))
                        .cornerRadius(8)
                }
            }.background(Color("coklat"))
                .scrollContentBackground(.hidden)
        }.background(Color("coklat"))
            .frame(width: 578, height: 428)
        
//            .presentedWindowStyle()
            
            
        }
    }
            

struct CBroHome_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct MyWindowStyle: WindowStyle {
//    func makeBody(configuration: WindowStyleComponents.Configuration) -> some View {
//        configuration
//            .window
//            .resizable(false)
//            .frame(minWidth: 200, minHeight: 200)
//    }
//}

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

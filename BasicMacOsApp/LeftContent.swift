//
//  LeftContent.swift
//  CBro
//
//  Created by Gregorius Yuristama Nugraha on 25/03/23.
//

import SwiftUI

struct LeftContent: View {
    @Binding var showFloat: Bool
    var body: some View {
        HStack {
            VStack {
                ZStack (alignment: .custom){
                    Image("bubble")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 10)
                        .padding(.leading, 13)
                    VStack {
                        Text("\(kGreetingText.randomElement()!)👋")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                                                            .padding(.leading, 20)
                            .padding(.bottom, 5)
                            .padding (.top, -125)
                            .foregroundColor(.black)
                            .frame(width: 230)
                        
                        Text("I have something to say you today:")
                        //                                    .fontWeight(.regular)
                            .font(.title2)
                            .padding(.bottom, 5)
                            .padding(.leading, -2)
                            .padding(.top, -80)
                            .foregroundColor(.black)
                            .frame(width: 230)
                        
                        Text("Be the largest rodent your field, and to strive measure up to your full potential.")
                            .font(.system(size: 18))
                            .bold()
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.top, -20)
                            .padding(.leading, 14)
                            .fontWeight(.bold)
                            .frame(width: 230)
                    }
                    Toggle(isOn: $showFloat) {
                        if !showFloat{
                            Text("Release Me")
                                .foregroundColor(.white)
                            
                                .frame(width: 76)
                            
                        }else{
                            Text("Catch Me")
                                .foregroundColor(.white)
                                .frame(width: 76)
                        }
                    }  .toggleStyle(.switch)
                    
                        .alignmentGuide(HorizontalAlignment.custom)
                    { d in d[.trailing] * -0.1}
                        .alignmentGuide(VerticalAlignment.custom)
                    { d in d[.bottom] * -8}
                }
                
            }
        }
        .padding()
        .frame(width: 270, height: 440)
        .background(Color("tosca"))
    }
}


struct LeftContent_Previews: PreviewProvider {
    static var previews: some View {
        LeftContent(showFloat: .constant(false))
    }
}

//
//  ProgressView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 23/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI

//this view is responsible to handle the ProgressBar View
struct ProgressView: View {
    @Binding var progress: CGFloat
    var body: some View {
        let percent = (10 - progress) / 10
        return VStack {
            ZStack {
                //Created circle instead of a bar to save the space and make it look good.
                Circle() //this is outer circle to show the progress
                    .trim(from: percent, to: 1)
                    .stroke(LinearGradient.init(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing), style: StrokeStyle.init(lineWidth: 6, lineCap: .round))
                    .rotationEffect(Angle.init(degrees: 90))
                    .rotation3DEffect(Angle.init(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .frame(width: 30, height: 30)
                 
                Circle() //this is inner cirlce
                    .stroke(Color(UIColor.systemGray).opacity(0.3), style: StrokeStyle(lineWidth: 5))
                    .frame(width: 30, height: 30)
                    .environment(\.colorScheme, .dark)
            }.padding()
        }
    }
}

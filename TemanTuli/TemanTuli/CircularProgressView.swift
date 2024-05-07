//
//  CircularProgressView.swift
//  TemanTuli
//
//  Created by Hilmy Noerfatih on 26/05/23.
//

import SwiftUI

struct CircularProgressView: View {
    @Binding var progress: Double
    @Binding var isDone: Bool
//    let progress = 0.3
//    let isDone = true
    
    var body: some View {
        ZStack {
            if (!isDone){
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color(hex: "7261D5"),
                        style: StrokeStyle(lineWidth: 30, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
            }else{
                Circle()
                    .foregroundColor(Color(hex: "F3F0FF"))
                Circle()
                    .stroke(
                        Color(hex: "7261D5"),
                        style: StrokeStyle(lineWidth: 30, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height:100)
                    .foregroundColor(Color(hex: "7261D5"))
                    .fontWeight(.black)
                
                Button(action: {
                    isDone = false
                    progress = 0
                }) {
                    Text("Retry")
                        .font(.title)
                        .padding(EdgeInsets(top: 5, leading: 60, bottom: 5, trailing: 60))
                        .background(Color(hex: "7261D5"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .offset(y: 170)
            }
        }
    }
}

//struct CircularProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularProgressView()
//            .frame(width: 200, height: 200)
//    }
//}

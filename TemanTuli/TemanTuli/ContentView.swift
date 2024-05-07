//
//  ContentView.swift
//  TemanTuli
//
//  Created by Hilmy Noerfatih on 23/05/23.
//

import SwiftUI
struct ContentView: View {
    @State private var classifiedSign = "None"
    @State private var isDone = false
    @State var progress: Double = 0
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                VStack {
                    ARSCNCameraContainer(classifiedSign: $classifiedSign, progress: $progress, isDone: $isDone, sign: "O")
                }
                .frame(width: 343, height: 637)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(hex: "7261D5"), lineWidth: 5)
                )
            .padding(20)
            }
            
            VStack{
                ZStack {
                    ZStack{
                        Circle()
                            .stroke(Color(hex: "7261D5"), lineWidth: 5)
                            .overlay(
                                Circle()
                                    .foregroundColor(Color(hex: "F3F0FF"))
                                )
                            .padding(EdgeInsets(top: 40, leading: 120, bottom: 40, trailing: 120))
                        Image("sign-o")
                    }.ignoresSafeArea()
                    
                    VStack {
                        Spacer().frame(height: 40)
                        Text("O")
                            .font(.title)
                            .padding(EdgeInsets(top: 5, leading: 60, bottom: 5, trailing: 60))
                            .background(Color(hex: "7261D5"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                Spacer()
                Text("\(classifiedSign)")
                    .font(.title)
                    .frame(width: 200, height: 50)
                    .background(.white)
                    .foregroundColor(Color(hex: "7261D5"))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: "7261D5"), lineWidth: 5)
                    )
            }
            CircularProgressView(progress: $progress, isDone: $isDone)
                .frame(width: 200, height: 200)
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//
//  ContentView.swift
//  WiggleTest
//
//  Created by Brian Simmons on 4/4/25.
//

//import SwiftUI
//
//struct ContentView: View {
//    @State private var animateViewIn = false
//    @State private var hintWiggle = false
//    
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                Spacer()
//                
//                VStack {
//                    if animateViewIn {
//                        Image(systemName: "questionmark.app.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100)
//                            .foregroundColor(.green)
//                            .rotationEffect(.degrees(hintWiggle ? -13 : -17))
//                            .padding()
//                            .transition(.offset(x: -geo.size.width / 2 ))
//                            .onAppear {
//                                withAnimation(.easeInOut(duration: 0.1).repeatCount(9).delay(5).repeatForever()) {
//                                    hintWiggle = true
//                                }
//                            }
//                    }
//                }
//                .animation(.easeOut(duration: 1.5).delay(2), value: animateViewIn)
//                
//                Spacer()
//            }
//            .padding()
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            animateViewIn = true
//        }
//    }
//}

import SwiftUI

struct ContentView: View {
    @State private var animateViewIn = false
    @State private var hintWiggle = false
    @State private var wiggleTimer: Timer? = nil
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                VStack {
                    if animateViewIn {
                        Image(systemName: "questionmark.app.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundColor(.green)
                            .rotationEffect(.degrees(hintWiggle ? -13 : -17))
                            .padding()
                            .transition(.offset(x: -geo.size.width / 2 ))
                            .onAppear {
                                startWiggling()
                            }
                    }
                }
                .animation(.easeOut(duration: 1.5).delay(2), value: animateViewIn)
                
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewIn = true
        }
    }
    
    private func startWiggling() {
        // Start a repeating timer
        wiggleTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1).repeatCount(9, autoreverses: true)) {
                hintWiggle.toggle()
            }
            
            // Toggle back after wiggle is done (roughly 0.9s)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                hintWiggle.toggle()
            }
        }
    }
}


#Preview {
    VStack {
        ContentView()
    }
}

//
//  HomeView.swift
//  Guide
//
//  Created by Feng Yuan Yap on 2022/06/19.
//

import SwiftUI

struct HomeView: View {
  @AppStorage("onBoarding") var isOnboardingView: Bool = false
  @State private var isAnimating: Bool = false
  
  var body: some View {
    VStack(spacing: 20) {
      Spacer()
      
      ZStack {
        AppCircle(isFirst: false)
        
        Image("character-2")
          .resizable()
          .scaledToFit()
          .padding()
          .offset(y: isAnimating ? 35 : -35)
          .animation(Animation.easeInOut(duration: 4).repeatForever(), value: isAnimating)
      } // :Center

      Text("""
      The time that leads to mastery is
      dependent on the intensity of our focus.
      """)
      .font(.title3)
      .fontWeight(.light)
      .multilineTextAlignment(.center)
      .foregroundColor(.secondary)
      .padding(.horizontal, 10)
      
      Spacer()
      
      Button {
        withAnimation{
          playSound(sound: "success", type: "m4a")
          isOnboardingView = true
        }
      } label: {
        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
          .imageScale(.large)

        Text("OnBoarding")
          .font(.system(.title3, design: .rounded))
          .fontWeight(.bold)
      } // :Button
      .buttonStyle(.borderedProminent)
      .buttonBorderShape(.capsule)
      .controlSize(.large)
    } // :VStack
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        isAnimating = true
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

//
//  OnboardingView.swift
//  Guide
//
//  Created by Feng Yuan Yap on 2022/06/19.
//

import SwiftUI

struct OnboardingView: View {
  @AppStorage("onBoarding") var isOnboardingActive: Bool = true
  @State private var swipeWidth: Double = UIScreen.main.bounds.width - 80
  @State private var buttonOffset: CGFloat = 0
  @State private var isAnimating: Bool = false
  let BUTTON_WIDTH: CGFloat = 80
  
  var getOpacity: Double {
    return isAnimating ? 1 : 0
  }
  
  var body: some View {
    ZStack {
      Color.appBlue
        .ignoresSafeArea(.all, edges: .all)
      
      VStack(spacing: 20) {
        // MARK: - Header
        Spacer()

        VStack(spacing: 0) {
          Text("Share.")
            .font(.system(size: 60))
            .fontWeight(.heavy)
          .foregroundColor(.white)
        
          Text("""
          It is not how much we give but
          how much love we put into giving.
          """)
            .font(.title3)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
        } // :Header
        .opacity(getOpacity)
        .offset(y: isAnimating ? 0 : -40)
        .animation(.easeOut(duration: 1), value: isAnimating)
        
        // MARK: - Center
        ZStack {
          AppCircle(isFirst: true)
          
          Image("character-1")
            .resizable()
            .scaledToFit()
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 0.5), value: isAnimating)
        } // :Center
        
        Spacer()
        
        // MARK: - Footer
        
        ZStack {
          Capsule()
            .fill(.white.opacity(0.2))
          Capsule()
            .fill(.white.opacity(0.2))
            .padding(8)
          
          Text("Get started")
            .font(.system(.title3, design: .rounded))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .offset(x: 20)
          
          HStack {
            Capsule()
              .fill(Color.appRed)
              .frame(width: buttonOffset + BUTTON_WIDTH)
            
            Spacer()
          }
          
          HStack {
            ZStack {
              Circle()
                .fill(Color.appRed)
              Circle()
                .fill(Color.black.opacity(0.2))
                .padding(8)
              Image(systemName: "chevron.right.2")
                .font(.system(size: 24, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(width: BUTTON_WIDTH, height: BUTTON_WIDTH, alignment: .center)
            .offset(x: buttonOffset)
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if gesture.translation.width > 0 && buttonOffset <= swipeWidth - BUTTON_WIDTH {
                    buttonOffset = gesture.translation.width
                  }
                }
                .onEnded{ _ in
                  withAnimation(Animation.easeOut(duration: 0.4)) {
                    if buttonOffset >= swipeWidth / 2 {
                      buttonOffset = swipeWidth - BUTTON_WIDTH
                      isOnboardingActive = false
                    } else {
                      buttonOffset = 0
                    }
                  }
                }
            ) // :Gesture
            
            Spacer()
          } // :HStack
        } // :Footer
        .frame(width: swipeWidth, height: BUTTON_WIDTH, alignment: .center)
        .padding()
        .opacity(getOpacity)
        .offset(y: isAnimating ? 0 : 40)
        .animation(.easeOut(duration: 1), value: isAnimating)
      } // :VStack
    } // :ZStack
    .onAppear {
      isAnimating = true
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
      OnboardingView()
  }
}

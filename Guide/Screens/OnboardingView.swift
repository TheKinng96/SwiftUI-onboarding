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
  @State private var imageOffset: CGSize = .zero
  @State private var opacityIndicator: Double = 1.0
  @State private var titleText: String = "Share."
  
  let hapticFeedback = UINotificationFeedbackGenerator()
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
          Text(titleText)
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .transition(.opacity)
            .id(titleText)
        
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
            .offset(x: imageOffset.width * -1)
            .blur(radius: abs(imageOffset.width / 5))
            .animation(.easeOut(duration: 0.5), value: imageOffset)
          
          Image("character-1")
            .resizable()
            .scaledToFit()
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 0.5), value: isAnimating)
            .offset(x: imageOffset.width * 1.2, y: 0)
            .rotationEffect(.degrees(Double(imageOffset.width / 20)))
            .gesture(
              DragGesture()
                .onChanged({ gesture in
                  if abs(imageOffset.width) <= 150 {
                    imageOffset = gesture.translation
                    
                    withAnimation(.linear(duration: 0.25)) {
                      opacityIndicator = 0
                      titleText = "Give."
                    }
                  }
                })
                .onEnded({ _ in
                  imageOffset = .zero
                  withAnimation(.linear(duration: 0.25)) {
                    opacityIndicator = 1.0
                    titleText = "Share."
                  }
                })
            ) // :Gesture
            .animation(.easeOut(duration: 0.5), value: imageOffset)
        } // :Center
        .overlay(
          Image(systemName: "arrow.left.and.right.circle")
            .font(.system(size: 44, weight: .ultraLight))
            .foregroundColor(.white)
            .offset(y: 20)
            .opacity(getOpacity)
            .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
            .opacity(opacityIndicator)
          , alignment: .bottom
        )
        
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
                      hapticFeedback.notificationOccurred(.success)
                      playSound(sound: "chimeup", type: "mp3")
                      buttonOffset = swipeWidth - BUTTON_WIDTH
                      isOnboardingActive = false
                    } else {
                      hapticFeedback.notificationOccurred(.warning)
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
    .preferredColorScheme(.dark)
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
      OnboardingView()
  }
}

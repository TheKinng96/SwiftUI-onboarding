//
//  OnboardingView.swift
//  Guide
//
//  Created by Feng Yuan Yap on 2022/06/19.
//

import SwiftUI

struct OnboardingView: View {
  @AppStorage("onBoarding") var isOnboardingActive: Bool = true
  
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
        
        // MARK: - Center
        AppCircle(isFirst: true) // :Center
        
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
              .frame(width: 80)
            
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
            .frame(width: 80, height: 80, alignment: .center)
            .onTapGesture {
              isOnboardingActive = false
            }
            
            Spacer()
          } // :HStack
        } // :Footer
        .frame(height: 80, alignment: .center)
        .padding()
      } // :VStack
    } // :ZStack
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
      OnboardingView()
  }
}

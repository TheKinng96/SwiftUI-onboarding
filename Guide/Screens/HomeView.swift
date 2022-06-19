//
//  HomeView.swift
//  Guide
//
//  Created by Feng Yuan Yap on 2022/06/19.
//

import SwiftUI

struct HomeView: View {
  @AppStorage("onBoarding") var isOnboardingView: Bool = false
  
  var body: some View {
    VStack(spacing: 20) {
      Spacer()
      
      AppCircle(isFirst: false)
        .padding()

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
        isOnboardingView = true
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
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

//
//  ContentView.swift
//  Guide
//
//  Created by Feng Yuan Yap on 2022/06/19.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("onBoarding") var isOnboardingActive: Bool = true

  var body: some View {
    ZStack {
      if (isOnboardingActive) {
        OnboardingView()
      } else {
        HomeView()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}

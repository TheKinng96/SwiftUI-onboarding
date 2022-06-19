//
//  appCircle.swift
//  Guide
//
//  Created by Feng Yuan Yap on 2022/06/19.
//

import SwiftUI

struct AppCircle: View {
  @State public var isFirst: Bool
  @State public var isAnimating: Bool = false
  
  var ShapeOpacity: Double {
    return isFirst ? 0.2 : 0.1
  }
  
  var ShapeColor: Color {
    return isFirst ? .white : .black
  }
  
  var body: some View {
    ZStack {
      Circle()
        .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
        .frame(width: 260, height: 260, alignment: .center)
      Circle()
        .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
        .frame(width: 260, height: 260, alignment: .center)
    } // :ZStack
    .blur(radius: isAnimating ? 0 : 10)
    .opacity(isAnimating ? 1 : 0)
    .scaleEffect(isAnimating ? 1 : 0.5)
    .animation(.easeOut(duration: 1), value: isAnimating)
    .onAppear(perform: {
      isAnimating = true
    })
  }
}

struct AppCircle_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.appBlue
        .ignoresSafeArea(.all, edges: .all)

      AppCircle(isFirst: true)
    }
  }
}

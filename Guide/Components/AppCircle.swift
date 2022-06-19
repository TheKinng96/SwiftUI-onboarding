//
//  appCircle.swift
//  Guide
//
//  Created by Feng Yuan Yap on 2022/06/19.
//

import SwiftUI

struct AppCircle: View {
  @State var isFirst: Bool

  var getImageNumber: String {
    return isFirst ? "1" : "2"
  }
  
  var ShapeOpacity: Double {
    return isFirst ? 0.2 : 0.1
  }
  
  var ShapeColor: Color {
    return isFirst ? .white : .black
  }
  
  var body: some View {
    ZStack {
      ZStack {
        Circle()
          .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
          .frame(width: 260, height: 260, alignment: .center)
        Circle()
          .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
          .frame(width: 260, height: 260, alignment: .center)
      } // :ZStack
      
      Image("character-\(getImageNumber)")
        .resizable()
        .scaledToFit()
    } // :Center
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

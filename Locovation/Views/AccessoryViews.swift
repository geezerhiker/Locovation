//
//  AccessoryViews.swift
//  Core Location Test
//
//  Created by Alan Heezen on 2/12/22.
//

import SwiftUI

struct PairView: View {
  let leftText: String
  let rightText: String
  
  var body: some View {
    HStack {
      Text(leftText)
      //            Spacer()
      Text(rightText)
    }
  }
}



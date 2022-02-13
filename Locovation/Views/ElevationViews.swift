//
//  ElevationViews.swift
//  Core Location Test
//
//  Created by Alan Heezen on 2/12/22.
//

import SwiftUI
import CoreMotion

struct ElevationStudyView: View {
  
  var elevation: ElevationViewModel
  
  var body: some View {
    HStack {
      Text("Relative").foregroundColor(.red)
      VStack {
        HStack {
          Text("max")
          Text(String(self.elevation.max))
        }
        HStack {
          Text("min")
          Text(String(elevation.min))
        }
      }
      VStack {
        HStack {
          Text("gain")
          Text(String(elevation.gain))
        }
        HStack {
          Text("loss")
          Text(String(elevation.loss))
        }
      }
      HStack {
        Text("gain-loss")
        Text(String(elevation.gain - elevation.loss))
      }
    }
    .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
  }
}


//
//  ElevationViews.swift
//  Core Location Test
//
//  Created by Alan Heezen on 2/12/22.
//

import SwiftUI
import CoreMotion

struct ElevationStudyView: View {
  @EnvironmentObject var locationViewModel: LocationViewModel
  //  @EnvironmentObject var elevationViewModel: ElevationViewModel
  
  var body: some View {
    if locationViewModel.elevationIsReady {
      let elevVM: ElevationViewModel? = locationViewModel.elevationViewModel
      if elevVM == nil {
        Spacer()
        Text("WTF")
        Spacer()
      } else {
        
        Spacer()
        HStack {
          Text("Relative").foregroundColor(.red)
          VStack {
            HStack {
              Text("max")
              ShortText(value: elevVM!.maximum)
//              Text(elevVM!.maxString)
            }
            HStack {
              Text("min")
              ShortText(value: elevVM!.minimum)
            }
          }
          Spacer()
          VStack {
            HStack {
              Text("gain")
              ShortText(value: elevVM!.gain)
            }
            HStack {
              Text("loss")
              ShortText(value:elevVM!.loss)
            }
            HStack {
              Text("elevation")
              ShortText(value:elevVM!.elevation)
            }
          }
          Spacer()
          VStack {
            HStack {
              Text("gain-loss")
              ShortText(value: elevVM!.gain - elevVM!.loss)
            }
            HStack {
              Text("count")
              ShortText(value:Double(elevVM!.altimeterCount))
            }
          }
        }
        .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
        Spacer()
      }
    } else {
      Spacer()
      Text("Waiting for GPS elevation...")
        .foregroundColor(.red)
        .bold()
      Spacer()
    }
  }
}


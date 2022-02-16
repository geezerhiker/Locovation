//
//  ElevationViewModel.swift
//  Core Location Test
//
//  Created by Alan Heezen on 2/9/22.
//

import SwiftUI
import CoreMotion
import CoreLocation

class ElevationViewModel: CMAltimeter, ObservableObject {
  @Published var elevation: CLLocationDistance
  
  private var locationModel: LocationViewModel?
  private var relativeAltitude: CLLocationDistance
  private var baseElevation: CLLocationDistance
  
  init(at elevation: CLLocationDistance, in model: LocationViewModel) {
    locationModel = model
    self.elevation = elevation
    baseElevation = elevation
    relativeAltitude = 0.0
    super.init()
    start()
  }
  
  var isReady = false
  var altimeterCount: Int = 0
  var cmAltimeter: CMAltimeter = CMAltimeter()
  
  var maximum = 0.0, minimum = 0.0, gain = 0.0, loss = 0.0
  var delta = 0.0
  var maxString: String {
    String(String(maximum * 100).prefix(6))
  }
  var minString: String {
    String(String(minimum * 100).prefix(6))
  }

//  mutating
  func update(with newAltitude: CLLocationDistance) {
    altimeterCount += 1
    maximum = max(maximum, newAltitude)
    minimum = min(minimum, newAltitude)
    let diff = newAltitude - relativeAltitude
    if diff > 0.0 {
      gain += diff
    } else {
      loss -= diff
    }
    relativeAltitude = newAltitude
    elevation = relativeAltitude + baseElevation
    locationModel?.adjustedElevation = elevation
    debugPrint("elev upgrade \(relativeAltitude), \(elevation)")
  }
  
//  mutating
  func start() {
//    self.baseElevation = elevation
    //start elevation updates
    if CMAltimeter.isRelativeAltitudeAvailable() {
      self.startRelativeAltitudeUpdates(to: OperationQueue.main) { [self] altitudeData, error in
        guard let altitudeData = altitudeData else {
          debugPrint(error! as NSError)
          return
        }
        let newAltitude = CLLocationDistance(truncating: altitudeData.relativeAltitude)
        DispatchQueue.main.async {
          update(with: newAltitude)
        }
      }
    }
  }

}

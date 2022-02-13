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
  @Published var altitude: CLLocationDistance
  
  //    private let elevationManager: CMAltimeter
  
  override init() {
    
    altitude = 0
    //start up elevation updates
    super.init()
  }
  var altimeterCount: Int = 0
  var cmAltimeter: CMAltimeter = CMAltimeter()
  
  var max = 0.0, min = 0.0, gain = 0.0, loss = 0.0
  var delta = 0.0
      
//  mutating
  func update() {
//        print("update \(max)")
      max += 2.0
      self.altimeterCount += 1
  }
  
//  mutating
  func startUp() {
      min -= 10.0
  }

}



/*
struct Altimeter {
//class Altimeter {
    
//    @Binding
    var altimeterCount: Int = 0
    var cmAltimeter: CMAltimeter = CMAltimeter()
    
    var max = 0.0, min = 0.0, gain = 0.0, loss = 0.0
    var delta = 0.0
        
    mutating
    func update() {
//        print("update \(max)")
        max += 2.0
        self.altimeterCount += 1
    }
    
    mutating func startUp() {
        min -= 10.0
    }
}
 */

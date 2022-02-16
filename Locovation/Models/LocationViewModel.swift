//
//  LocationViewModel.swift
//  Core Location Test
//
//  Created by Andy Ibanez on 3/13/21.
//

import Foundation
import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject {
  @Published var authorizationStatus: CLAuthorizationStatus
  @Published var lastSeenLocation: CLLocation?
  @Published var currentPlacemark: CLPlacemark?
  @Published var adjustedElevation: CLLocationDistance?
  @Published var elevationViewModel: ElevationViewModel?

  private let locationManager: CLLocationManager

  var elevationIsReady = false
  override init() {
    locationManager = CLLocationManager()
    authorizationStatus = locationManager.authorizationStatus
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = 0.0
    locationManager.startUpdatingLocation()
  }
  
  func requestPermission() {
    locationManager.requestWhenInUseAuthorization()
  }
  
  func fetchCountryAndCity(for location: CLLocation?) {
    guard let location = location else { return }
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
      self.currentPlacemark = placemarks?.first
    }
  }
}

extension LocationViewModel: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    authorizationStatus = manager.authorizationStatus
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let currentLocation = locations.last else { return }
    lastSeenLocation = currentLocation
    debugPrint("did update to \(String(describing: lastSeenLocation))")
    fetchCountryAndCity(for: currentLocation)
    
    if !elevationIsReady {
      let verticalError = currentLocation.verticalAccuracy
      debugPrint("vertical error = \(verticalError)")
      if verticalError > 0.0 && verticalError <= 5.0 {
        elevationViewModel = ElevationViewModel(at: currentLocation.altitude, in: self)
        elevationIsReady = true
      }
    }
  }
  func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
    let x = 1
  }
}
/*
 snippet 1
 class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
 private let locationManager: CLLocationManager
 
 override init() {
 locationManager = CLLocationManager()
 
 super.init()
 locationManager.delegate = self
 }
 }
 */


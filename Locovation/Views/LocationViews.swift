//
//  LocationViews.swift
//  Core Location Test
//
//  Created by Alan Heezen on 2/12/22.
//

import SwiftUI
import CoreLocation

struct TrackingView: View {
  @EnvironmentObject var locationViewModel: LocationViewModel
  @EnvironmentObject var elevationViewModel: ElevationViewModel
    
  var body: some View {
    VStack {
      Spacer(minLength: 100.0)
      VStack {
        PairView(
          leftText: "Latitude:",
          rightText: String(String(coordinate?.latitude ?? 0).prefix(8))
        )
        PairView(
          leftText: "Longitude:",
          rightText: String(String(coordinate?.longitude ?? 0).prefix(10))
        )
        PairView(
          leftText: "Altitude",
          rightText: String(String(locationViewModel.lastSeenLocation?.altitude ?? 0).prefix(8))
        )
        
        ElevationStudyView(elevation: elevationViewModel)
        
        PairView(
          leftText: "Speed:",
          rightText: String(String(locationViewModel.lastSeenLocation?.speed ?? 0).prefix(6))
        )
        PairView(
          leftText: "Country:",
          rightText: locationViewModel.currentPlacemark?.country ?? ""
        )
        PairView(leftText: "State:", rightText: locationViewModel.currentPlacemark?.administrativeArea ?? ""
        )
        PairView(leftText: "County:", rightText: locationViewModel.currentPlacemark?.subAdministrativeArea ?? ""
        )
        PairView(leftText: "City:", rightText: locationViewModel.currentPlacemark?.locality ?? ""
        )
      }
      .padding()
      Spacer(minLength: 100.0)
    }
  }
  
  var coordinate: CLLocationCoordinate2D? {
    locationViewModel.lastSeenLocation?.coordinate
  }
}


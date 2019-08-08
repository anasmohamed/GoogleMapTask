//
//  MapPresenter.swift
//  GoogleMapTask
//
//  Created by jets on 12/6/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import Foundation
import MapKit
import Firebase
protocol MapPresenterProtocol {
    func getCityNameFromLatitudeAndLongtitude(latitude :CLLocationDegrees, longitude: CLLocationDegrees,locationModel:LocationModel)
    func saveLocation(location: LocationModel,ref : DatabaseReference)
}
class MapPresenter: MapPresenterProtocol {
    
    func getCityNameFromLatitudeAndLongtitude(latitude :CLLocationDegrees, longitude: CLLocationDegrees,locationModel :LocationModel)
    {
        var  insidelocationModel : LocationModel!
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude:latitude, longitude:longitude )
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                
                // Place details
                guard let placeMark = placemarks?.first else { return }
                
                // City
                if let city = placeMark.subAdministrativeArea {
                    
                  locationModel.city = city
                  locationModel.country = placeMark.country!
                }
                
        })
       
        
    }
    func saveLocation(location locationModel: LocationModel,ref: DatabaseReference)
    {
        print("location city :\(locationModel.city)")
        ref.child("users").child((Auth.auth().currentUser?.uid)!).child("loctions").childByAutoId().setValue(["city":locationModel.city,"country":locationModel.country])
    }
}

//
//  HomeViewController.swift
//  GoogleMapTask
//
//  Created by jets on 12/4/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

class HomeViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate,UISearchBarDelegate {
    var locationManager:CLLocationManager!
    var searchController:UISearchController!
    let alert = Alert()
    var locationModel = LocationModel()
    var ref: DatabaseReference!
    var user = User()
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelHomeUserName: UILabel!
    @IBOutlet weak var labelHomePassword: UILabel!
    @IBOutlet weak var labelHomeToken: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
       
      
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
        labelHomeUserName.text = user.userName
        labelHomePassword.text = user.password
        labelHomeToken.text = user.uid
    }
    
    @IBAction func saveLocation(_ sender: Any) {
        print("location city :\(self.locationModel.city)")
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("loctions").childByAutoId().setValue(["city":locationModel.city,"country":locationModel.country])

    }
    @IBAction func showSearchBar(_ sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }

    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations.last! as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        getCityNameFromLatitudeAndLongtitude(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
    }
    // Add below code to get address for touch coordinates.
    func getCityNameFromLatitudeAndLongtitude(latitude :CLLocationDegrees, longitude: CLLocationDegrees )
    {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude:latitude, longitude:longitude )
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                
                // Place details
                guard let placeMark = placemarks?.first else { return }
                
                // City
                if let city = placeMark.subAdministrativeArea {
                
                    self.locationModel = LocationModel(city: placeMark.subAdministrativeArea!, country: placeMark.country!)
                }
               
             
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
           
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                self.alert.showAlert(title: "Error", message: "Sorry, the City Name you entered is not correct", actions:[(title:"Try Again",action: {
                    self.dismiss(animated: true, completion: nil)
                })])
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                self.getCityNameFromLatitudeAndLongtitude(latitude: latitude!, longitude: longitude!)
                //Create annotation
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }
    @IBAction func locationTableButtonDidTabbed(_ sender: Any) {
        let locationVC = storyboard?.instantiateViewController(withIdentifier: "LocationsTableVC") as! SavedLocationsTableViewController
        locationVC.user = user
        self.present(locationVC, animated: true, completion: nil)
        
        
    }
}

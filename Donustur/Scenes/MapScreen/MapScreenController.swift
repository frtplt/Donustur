//
//  MapScreenController.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapScreenController: UIViewController, MKMapViewDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            self.mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        var itemLatitude = chosenLatitude
        var itemLongitude = chosenLongitude
        var itemSender = "\(Auth.auth().currentUser?.email)"
        
        db.collection("MapInformations").addDocument(data: ["ItemLatitude" : itemLatitude,
                                                            "ItemLongitude" : itemLongitude,
                                                            "ItemSender" : itemSender,
                                                           ]) { error in
            if let e = error {
                self.showError(message: "There was an issue saving Firestore")
            } else {
                print("Succesfully saved")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension MapScreenController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude , longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
}

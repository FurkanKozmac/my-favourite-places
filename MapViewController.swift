//
//  MapViewController.swift
//  MyFavoutitePlaces
//
//  Created by Furkan Kozmaç on 4.08.2023.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore
import FirebaseAuth

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    // MARK: Setting up UI
    
    private func setupUI() {
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        // MARK: Constraints
        
        NSLayoutConstraint.activate([
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupUI()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = "Title"
            annotation.subtitle = "Subtitle"
            self.mapView.addAnnotation(annotation)
            
            let vc = CommentViewController()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
            
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}

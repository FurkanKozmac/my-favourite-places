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
    private var annotation = MKPointAnnotation()
    
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
        
        
        fetchFirestoreLocationData()
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            let newAnnotation = MKPointAnnotation() // Create a new annotation
            newAnnotation.coordinate = touchedCoordinates
            newAnnotation.title = "Set place"
            self.mapView.addAnnotation(newAnnotation) // Add the new annotation to the map
            
            let vc = CommentViewController()
            vc.selectedCoordinates = touchedCoordinates
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
    }

    
    func fetchFirestoreLocationData() {
        let ref = db.collection("savedPlaces")
        
        ref.getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("no document.")
                return
            }
            
            DispatchQueue.main.async {
                for document in documents {
                    if let latitudeStr = document.data()["latitude"] as? String,
                       let longitudeStr = document.data()["longitude"] as? String,
                       let latitude = Double(latitudeStr),
                       let longitude = Double(longitudeStr) {
                        
                        
                        self.annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        self.annotation.title = document.data()["title"] as? String
                        self.annotation.subtitle = document.data()["comment"] as? String
                        
                        self.mapView.addAnnotation(self.annotation)
                    }
                }
            }
        }
    }

    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}

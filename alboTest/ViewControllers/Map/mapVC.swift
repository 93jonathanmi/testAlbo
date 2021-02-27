//
//  MapVC.swift
//  alboTest
//
//  Created by Jonathan Lopez on 26/02/21.
//

import UIKit
import MapKit

class mapVC: UIViewController {

    var dataMap = [ModelAirport]()
    var myLocationMap : CLLocation?
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func actBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderMyLocation(myLocationMap!)
        
        // Do any additional setup after loading the view.
    }
    
    func renderMyLocation (_ location: CLLocation){
        
        addPins()
        let  coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)

        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
        
        
    }
    
    func addPins() {
        
        for pinsData in dataMap {
            
            let newLatPin = pinsData.lat
            let newLonPin = pinsData.lon
            
            let newPin = MKPointAnnotation()
            
            newPin.coordinate = CLLocationCoordinate2D(latitude: newLatPin, longitude: newLonPin)
            
            mapView.addAnnotation(newPin)
            
            
        }
        
    }
    


}

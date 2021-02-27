//
//  ViewController.swift
//  alboTest
//
//  Created by Jonathan Lopez on 26/02/21.
//

import UIKit
import CoreLocation

class SearchAirportVC: UIViewController, CLLocationManagerDelegate {
    
    let manager : CLLocationManager = CLLocationManager()

    var myLocation : CLLocation?
    var myLat : Double?
    var myLon : Double?
    
    var modelReference = [ModelAirport]()
    
    var lat : Double?
    var lon : Double?
    
    var newKm : Int? = 1
    
    
    @IBOutlet weak var lblKm: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var sliderKm: UISlider!
    @IBOutlet weak var activityWait: UIActivityIndicatorView!
    
    @IBAction func moveKm(_ sender: Any) {
        
        newKm = Int(sliderKm.value)
        lblKm.text = "\(newKm!)"
    }
    
    @IBAction func actSearch(_ sender: Any) {
        

        switch(CLLocationManager.authorizationStatus())
                    {
                    case .notDetermined, .restricted, .denied:
                        self.openDeviceLocationSetting()
                        return
                    case .authorizedAlways, .authorizedWhenInUse:
                        //do whatever you want to do with location
                        
                        activityWait.startAnimating()
                        btnSearch.isEnabled = false
                        btnSearch.setTitle("", for: .normal)
                        
                        airportRequest()
                        
                        return
                    }
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // Send information to the TableView and Maps
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        let custMainVC = segue.destination as! UITabBarController
        let dataDestination = modelReference

        
        let viewMap = custMainVC.viewControllers![0] as! mapVC
        viewMap.dataMap = dataDestination
        viewMap.myLocationMap = myLocation
        
        let viewTable = custMainVC.viewControllers![1] as! tableAirportsVC
        viewTable.dataTable = dataDestination
        
    }
    
 
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else {
            return
        }
        
        
        
        myLocation = first
        myLat = first.coordinate.latitude
        myLon = first.coordinate.longitude
        
        manager.stopUpdatingLocation()
    }
    

    // Get informaton to the API
    func airportRequest(){
        
        
        let headers = [
            "x-rapidapi-key": "3230d4f917msh9ae3897402a2672p186f2ejsn5917879465ec",
            "x-rapidapi-host": "aerodatabox.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://aerodatabox.p.rapidapi.com/airports/search/location/\(myLat!)/\(myLon!)/km/\(newKm ?? 1)/16?withFlightInfoOnly=false")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            self.modelReference.removeAll()
            
            if (error != nil) {
                print(error)
                
                self.endAnimation()
            } else {
                
                do {
                    
                    
                    let parsedDictionaryArray = try JSONSerialization.jsonObject(with: data!) as! [String:AnyObject]
                    //print(parsedDictionaryArray)
                    
                    if let arry = parsedDictionaryArray["items"] as? [[String:AnyObject]] {
                        
                        for dic in arry {
                            let icao = dic["icao"] as! String
                            let iata = dic["iata"] as! String
                            let name = dic["name"] as! String
                            let shortName = dic["shortName"] as! String
                            let municipalityName = dic["municipalityName"] as! String
                            let countryCode = dic["countryCode"] as! String
                            
                            if let infoLocation = dic["location"] as? NSDictionary {
                                print(self.newKm)
                                let pointLat = infoLocation["lat"] as! Double
                                let pointLon = infoLocation["lon"] as! Double
                                
                                self.lat = pointLat
                                self.lon = pointLon
                                
                            }
                            
                            
                            
                            let newSearcAirport = ModelAirport(icao: icao, iata: iata, name: name, shortName: shortName, municipalityName: municipalityName, countryCode: countryCode, lat: self.lat!, lon: self.lon!)
                            
                            self.modelReference.append(newSearcAirport)
                            self.endAnimation()
                            
                            
                        }
                        
                        self.endAnimation()
                        
                        
                    }
                } catch let error as NSError {
                    
                    self.endAnimation()
                    
                    print(error)
                }
                
                
            }
        })
        
        dataTask.resume()
        
    }
    
    
    // Send and Stop Information , Stop animation
    func endAnimation() {
        
        DispatchQueue.main.async {
            self.activityWait.stopAnimating()
            self.btnSearch.isEnabled = true
            self.btnSearch.setTitle("Search", for: .normal)
            
            if self.modelReference.count == 0{
                
                let alertController = UIAlertController(title: "Search", message:
                                                            "This search did not get any results, try other values.", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler:nil))
                self.present(alertController, animated: true, completion: nil)
                
            }else{
                
                
                self.performSegue(withIdentifier: "goToTap", sender: self)
                
                
            }
        }
        
        
    }
    
    func openDeviceLocationSetting()
    {
        let alertController = UIAlertController(title: "", message:"For best results, let your device turn on Location.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            //self.isAlertShowing = false
            let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.openURL(url as URL)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in

        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

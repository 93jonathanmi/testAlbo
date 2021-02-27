//
//  ModelAirport.swift
//  alboTest
//
//  Created by Jonathan Lopez on 26/02/21.
//

import Foundation
class ModelAirport : NSObject{
    
    var icao : String
    var iata: String
    var name : String
    var shortName: String
    var municipalityName : String
    var countryCode: String
    var lat : Double
    var lon: Double
    
    
    init(icao : String, iata: String, name : String, shortName: String, municipalityName : String, countryCode: String, lat : Double,
     lon: Double)
    {
        self.icao = icao
        self.iata = iata
        self.name = name
        self.shortName = shortName
        self.municipalityName = municipalityName
        self.countryCode = countryCode
        self.lat = lat
        self.lon = lon
    }
}

//
//  airportCell.swift
//  alboTest
//
//  Created by Jonathan Lopez on 26/02/21.
//

import UIKit

class airportCell: UITableViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblShortName: UILabel!
    @IBOutlet weak var lblMunCou: UILabel!
    @IBOutlet weak var lblIcaoiata: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }


    
    func setInfoAirport(Modelo: ModelAirport){
        lblName.text = Modelo.name
        lblShortName.text = Modelo.shortName
        lblMunCou.text = "\(Modelo.municipalityName), \(Modelo.countryCode)"
        lblIcaoiata.text = "ICAO: \(Modelo.icao) | IATA: \(Modelo.iata)"
        
    }

}



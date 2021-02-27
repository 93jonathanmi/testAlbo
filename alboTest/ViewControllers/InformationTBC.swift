//
//  InformationTBC.swift
//  alboTest
//
//  Created by Jonathan Lopez on 26/02/21.
//

import UIKit

class InformationTBC: UITabBarController {

    
    var dataTab = [ModelAirport]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let finalVC = self.viewControllers![1] as! tableAirportsVC //first view controller in the tabbar
        finalVC.dataTable = dataTab
        // Do any additional setup after loading the view.
    }
    


}

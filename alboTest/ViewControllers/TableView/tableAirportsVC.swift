//
//  tableAirportsVC.swift
//  alboTest
//
//  Created by Jonathan Lopez on 26/02/21.
//

import UIKit

class tableAirportsVC: UIViewController {

    
    var dataTable = [ModelAirport]()
    
    @IBOutlet weak var tableAirports: UITableView!
    
    @IBAction func actBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableAirports.dataSource = self
        tableAirports.delegate = self
        // Do any additional setup after loading the view.
    }
    



}


extension tableAirportsVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAirport") as! airportCell
        let infoCell = dataTable[indexPath.row]
        cell.setInfoAirport(Modelo: infoCell)
        
        return cell
        
    }
    
    
    
    
}

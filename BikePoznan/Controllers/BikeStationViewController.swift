//
//  BikeStationViewController.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 31/05/2022.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa

class BikeStationViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
     var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    fileprivate let bag = DisposeBag()
    let bikeViewModel = BikeStationViewModel() 
    let filteredBikeList = BehaviorRelay<[Station]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bikeViewModel.fetchUserList()
        bindUI()
    }
    
    func bindUI() {
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { (value) in
            guard let location = value else {
                return
            }
            self.tableview.reloadData()
            self.userLocation = location
        },onError: { error in
            self.errorAlert()
        }).disposed(by: bag)

        bikeViewModel.bikeStationsListObserver.subscribe(onNext: { (value) in
            self.filteredBikeList.accept(value)
        },onError: { error in
            self.errorAlert()
        }).disposed(by: bag)
        tableview.tableFooterView = UIView()
        
        filteredBikeList.bind(to: tableview.rx.items(cellIdentifier: "StationTableViewCell", cellType: StationTableViewCell.self)) { row, model, cell in
            cell.configureCell(station: model)
            cell.distanceLabel.text = model.getDistance(userLocation: self.userLocation)
        }.disposed(by: bag)
        

        tableview.rx.itemSelected.subscribe(onNext: { (indexPath) in
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewID") as BikeStationsMapieViewController
            self.tableview.deselectRow(at: indexPath, animated: true)
            controller.station = self.filteredBikeList.value[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            
        }).disposed(by: bag)
        
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Check your Internet connection and Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



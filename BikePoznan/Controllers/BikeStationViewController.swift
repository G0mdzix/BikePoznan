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
    let bikeViewModelInstance = BikeStationViewModel()
    let filteredBikeList = BehaviorRelay<[BikeStationDetailViewModel]>(value: [])
    var controller: BikeStationsMapieViewController?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bikeViewModelInstance.fetchUserList()
        bindUI()
        controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewID") as BikeStationsMapieViewController
        
        Localization.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async { [self] in
                guard self != nil else {
                    return
                }
                self?.tableview.reloadData()
                self?.userLocation = location
            }
        }
         
    }
    
    func bindUI() {
        
        bikeViewModelInstance.bikeStationViewModelObserver.subscribe(onNext: { (value) in
            self.filteredBikeList.accept(value)
        },onError: { error in
            self.errorAlert()
        }).disposed(by: bag)
        tableview.tableFooterView = UIView()
        
        filteredBikeList.bind(to: tableview.rx.items(cellIdentifier: "StationTableViewCell", cellType: StationTableViewCell.self)) { row, model, cell in
            cell.configureCell(bikeStationDetail: model)
            cell.distanceLabel.text = model.getDistance(userLocation: self.userLocation)
        }.disposed(by: bag)
        

        tableview.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.tableview.deselectRow(at: indexPath, animated: true)
            self.controller?.stationDetail.accept(self.filteredBikeList.value[indexPath.row])
            self.navigationController?.pushViewController(self.controller ?? BikeStationsMapieViewController(), animated: true)
            
        }).disposed(by: bag)
        
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Check your Internet connection and Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



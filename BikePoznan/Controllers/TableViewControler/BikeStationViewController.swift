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
    @IBOutlet weak var searchTextField: UITextField!
    
    let refreshControl = UIRefreshControl()
    
    fileprivate let bag = DisposeBag()
    let bikeViewModel = BikeStationViewModel() 
    var filteredBikeList = BehaviorRelay<[BikeStationDetailViewModel]>(value: []) 
    let bikeList = BehaviorRelay<[BikeStationDetailViewModel]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bikeViewModel.fetchUserList()
        bindUI()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.addSubview(refreshControl)
        view.setGradientBackground(colorOne: UIColor(named: "Background 1")!, colorTwo: UIColor(named: "Background 2")!)// #!!
    }
    
    @objc func refresh(_ sender: AnyObject) {
        bikeViewModel.fetchUserList()
        tableview.reloadData()
        refreshControl.endRefreshing()
    }
    
    func bindUI() {
       
        searchTextField.placeholder = "Poszukiwana stacja?"
        let textField = UITextField()
        textField.textContentType = .emailAddress
        
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { (value) in
            guard value != nil else {
                return
            }
            self.tableview.reloadData()
        },onError: { error in
            self.errorAlert()
        }).disposed(by: bag)

        bikeViewModel.bikeStationsListObserver.subscribe(onNext: { (value) in
            self.filteredBikeList.accept(value)
            self.bikeList.accept(value)
        },onError: { error in
            self.errorAlert()
        }).disposed(by: bag)
        tableview.tableFooterView = UIView()
        filteredBikeList.bind(to: tableview.rx.items(cellIdentifier: "StationTableViewCell", cellType: StationTableViewCell.self)) { row, model, cell in
            cell.configureCell(station: model)
            cell.animationOfLabels(station: model)
            
           
        }.disposed(by: bag)
        
        tableview.rx.itemSelected.subscribe(onNext: { (indexPath) in
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewID") as BikeStationsMapieViewController
            self.tableview.deselectRow(at: indexPath, animated: true)
            controller.station = self.filteredBikeList.value[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            
        }).disposed(by: bag)
        
        Observable.combineLatest(bikeList.asObservable(), searchTextField.rx.text, resultSelector: { users, search in
            return users.filter { (user) -> Bool in
                self.filterUserList(userModel: user, searchText: search )
            }
        }).bind(to: filteredBikeList).disposed(by: bag)
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Check your Internet connection and Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func filterUserList(userModel: BikeStationDetailViewModel, searchText: String?) -> Bool {
        if let search = searchText, !search.isEmpty, !(userModel.stationData.properties.label.contains(search) ) {
            return false
            
        }
        return true
    }
    
    
}


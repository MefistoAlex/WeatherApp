//
//  LocationSearchViewController.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import MapKit
import RxCocoa
import RxSwift
import UIKit

final class LocationSearchViewController: UIViewController {
    private let locationViewModel = LocationViewModel.shared
    private let disposeBag = DisposeBag()

    var mapView: MKMapView?

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Colors.darkBlue.rawValue)

        locationViewModel.locations.bind(to: tableView.rx.items(cellIdentifier: "location")) { _, elem, cell in
            cell.textLabel?.text = elem.name
            cell.detailTextLabel?.text = "\(elem.placemark)"

        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(MKMapItem.self).bind { mapItem in
            self.locationViewModel.pin.onNext(mapItem)
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
}

// MARK: UISearchResultsUpdating

extension LocationSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else { return }

        locationViewModel.searchRequest(text: searchBarText)
    }
}

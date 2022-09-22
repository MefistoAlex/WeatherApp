//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 21.09.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = UIColor(named: "DarkBlue")
        
        // set left bar button
        let placeButton = UIButton(type: .system)
        placeButton.setImage(UIImage(named: NavigationImages.place.rawValue), for: .normal)
        placeButton.setTitle("  Zaporizshya", for: .normal)
        placeButton.sizeToFit()
        placeButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: placeButton)

        // set right bar button
        let locationButton = UIButton(type: .system)
        locationButton.setImage(UIImage(named: NavigationImages.location.rawValue), for: .normal)
        locationButton.sizeToFit()
        locationButton.addTarget(self, action: #selector(locationSearch), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: locationButton)
        
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
    }

    @objc private func locationSearch() {
        let storyboaard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboaard.instantiateViewController(withIdentifier: String(describing: MapViewController.self)) as! MapViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: TableView Datasource

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayTempCell", for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.33 * view.bounds.height
    }
}

// MARK: TableView Delegate

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = WeatherHeader()
        return header
    }
}

//
//  HomeViewController.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/01.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var citiesTableView: UITableView!
    let viewModel = WeatherViewModel(weatherApi: WeatherHelperService())
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let actInd = UIActivityIndicatorView(style: .gray)
        actInd.translatesAutoresizingMaskIntoConstraints = false
        actInd.hidesWhenStopped = true
        return actInd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpNavBarAttributes()
        attemptFetchWeather()
    }
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        activityIndicator.startAnimating()
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        activityIndicator.stopAnimating()
    }
    
    private func setUpSubviews() {
        self.citiesTableView.register(UINib(nibName: CellIdentifiers.cityWeatherCell, bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.cityWeatherCell)
        self.citiesTableView.estimatedRowHeight = 120
        self.citiesTableView.rowHeight = UITableView.automaticDimension
        self.citiesTableView.alpha = 0.0
        self.citiesTableView.tableFooterView = UIView()
            
        view.addSubview(activityIndicator)
        // Auto layout
        let horizontalConstraint = activityIndicator
            .centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = activityIndicator
            .centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }

    private func setUpNavBarAttributes() {
        title = Titles.title
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 73/255, blue: 93/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    //MARK: - Custom Methods
    
    private func attemptFetchWeather() {
        viewModel.fetchWeather()
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            //Update UI
            self.citiesTableView.alpha = 1.0
            self.citiesTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.weatherData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cityWeatherCell, for: indexPath) as? CityWeatherCell, let data = self.viewModel.weatherData?[indexPath.row] else { return UITableViewCell()}
        cell.configure(weatherData: data)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController, let data = self.viewModel.weatherData?[indexPath.row] else { return}
        vc.weatherData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//
//  ViewController.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import UIKit
import CoreLocation

final class WeatherForDayVC: UIViewController, ManagerEventListener {
    
    // MARK: - Private properties
    private var weatherArray = [WeatherModel]()
    private let networkManager = NetworkManager()
    
    private lazy var city = String()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout )
        collectionView.backgroundColor = .orange
        collectionView.showsVerticalScrollIndicator = false
        collectionView.refreshControl = refreshControl
        collectionView.isPagingEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.Identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        
        return activityIndicator
    }()
    
    // MARK: - Override methods
    
     override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        GeolacationChange.shared.add(listener: self)
    }
    
    deinit {
        GeolacationChange.shared.remove(listener: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocation()
        view.backgroundColor = .orange
        setupLayoutCollectionView()
        setupLayoutActivityIndicator()
        startActivityIndicator()
        setupNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonItem))
    }
    
    // MARK: - Public methods
    
    func updateLocation(coordinate: CLLocationCoordinate2D) {
        networkManager.getLocation(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] results in
            
            self?.city = results?.city.name ?? ""
            self?.weatherArray = results?.weather.compactMap({ WeatherModel(weatherForDay: $0)}) ?? []
            
            DispatchQueue.main.async {
                self?.navigationItem.title = results?.city.name
                self?.collectionView.reloadData()
                self?.stopActivityIndicator()
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func searchBarButtonItem() {
        presentAlertController(title: "Новый город", message: "Для просмотра погоды введите название города", style: .alert) { [weak self] cityName in
            self?.fetchData(city: cityName)
            print(cityName)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        fetchLocation()
        refreshControl.endRefreshing()
    }
}

// MARK: - Private methods

private extension WeatherForDayVC {
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func fetchLocation() {
        if !GeolacationChange.shared.locationServicesisEnabled {
            GeolacationChange.shared.requestAuthorization()
            fetchLocationByIpAdress()
        }
        else {
            GeolacationChange.shared.requestLocation()
        }
    }
    
    func fetchLocationByIpAdress() {
        networkManager.getlocationByIpAdress { [weak self] location in
            if let location = location {
                self?.city = location.city
                self?.updateLocation(coordinate: location.locationCoordinate2D)
            }
        }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 33)]
        navigationController?.navigationBar.barTintColor = .white
    }
    
    func setupLayoutActivityIndicator() {
        collectionView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupLayoutCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -5)
        ])
    }
    
    func fetchData(city: String) {
        networkManager.getWeather(city: city) { [weak self] results in
            self?.city = city
            self?.weatherArray = results?.weather.compactMap({ WeatherModel(weatherForDay: $0)}) ?? []
            
            DispatchQueue.main.async  {
                self?.navigationItem.title = city
                self?.collectionView.reloadData()
            }
        }
    }
}

extension WeatherForDayVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.Identifier, for: indexPath) as? WeatherCell else {
            assertionFailure("this cell is missing")
            return UICollectionViewCell()
            
        }
        
        guard let model = weatherArray[safe: indexPath.row] else {
            assertionFailure("missing index outside the range")
            return UICollectionViewCell()
        }
        cell.setupWithModel(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 15
        return CGSize(width: width, height: 165)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetailScreen(indexPath: indexPath)
    }
    
    private func presentDetailScreen(indexPath: IndexPath) {
        
        guard let model = weatherArray[safe: indexPath.row]?.date else {
            assertionFailure("missing index outside the range")
            return
        }
        let detailWeatherForDayVC = DetailWeatherForDayVC()
        detailWeatherForDayVC.date = model
        detailWeatherForDayVC.city = city
        navigationController?.pushViewController(detailWeatherForDayVC, animated: true)
    }
}

private extension WeatherForDayVC {
    func presentAlertController(title: String?, message: String?, style: UIAlertController.Style, completion: @escaping (String) -> Void) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
              
        ac.addTextField { textField in
            self.setupTextField(textField: textField)
        }
        
        let search = UIAlertAction(title: "Поиск", style: .default) { _ in
            
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else {
                return
            }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completion(city)
            }
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    func setupTextField(textField: UITextField) {
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.placeholder = "Введите город"
        textField.autocapitalizationType = .words
        textField.textAlignment = .center
    }
}



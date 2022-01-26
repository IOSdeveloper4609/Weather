//
//  DetailWeatherForDayVC.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import UIKit

final class DetailWeatherForDayVC: UIViewController {
    
    // MARK: - Public properties
    
    lazy var date = Date()
    lazy var city = String()
    
    // MARK: - Private properties
    
    private var detaileWeatherArray = [CommonModel]()
    private var networkManager = NetworkManager()
    
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
        collectionView.register(DetailWeatherCell.self, forCellWithReuseIdentifier: DetailWeatherCell.Identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .red
        
        return activityIndicator
    }()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityIndicator()
        view.backgroundColor = .orange
        setupLayoutCollectionView()
        setupNavigationBar()
        setupLayoutActivityIndicator()
        fetchData(city: city)
    }
    
    // MARK: - Actions
    
    @objc func refresh(sender: UIRefreshControl) {
        fetchData(city: city)
        refreshControl.endRefreshing()
    }
}

// MARK: - Private methods

private extension DetailWeatherForDayVC {
     func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
     func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
     func setupNavigationBar() {
        navigationItem.title = "Погода на день"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        networkManager.getDetailWeather(city: city) { [weak self] results in
            
            let cellModels = results?.weather.compactMap({ CommonModel(description: $0.description.first?.description, temperatureDay: $0.temperature.temperature, date: $0.date, conditionCode: $0.description.first?.id )}) ?? []
            
            self?.detaileWeatherArray = self?.sortedWeather(model: cellModels) ?? []
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.stopActivityIndicator()
            }
        }
    }
    
    func sortedWeather(model: [CommonModel]) -> [CommonModel] {
        var detaileWeatherArray = [CommonModel]()
        
        let weatherModel = model.filter {$0.date.getDateComponent(.day) == self.date.getDateComponent(.day)}
        detaileWeatherArray.append(contentsOf: weatherModel)
        return  detaileWeatherArray
    }
}

// MARK: - DetaileWeatherForDayVC

extension DetailWeatherForDayVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detaileWeatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:DetailWeatherCell.Identifier, for: indexPath) as? DetailWeatherCell else {
            assertionFailure("this cell is missing")
            return UICollectionViewCell()
        }
        
        guard let model = detaileWeatherArray[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.setupWithModel(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 15
        return CGSize(width: width, height: 85)
    }
}



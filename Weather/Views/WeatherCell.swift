//
//  WeatherCell.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import UIKit

final class WeatherCell: BaseCell {
   
    // MARK: - Private properties
    
    private lazy var windLabel: UILabel = {
        let windLabel = UILabel()
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.font = windLabel.font.withSize(17)
        windLabel.alpha = 0.8
        windLabel.textColor = .black
        
        return windLabel
    }()
    
    private lazy var rainLabel: UILabel = {
        let rainLabel = UILabel()
        rainLabel.translatesAutoresizingMaskIntoConstraints = false
        rainLabel.font = rainLabel.font.withSize(17)
        rainLabel.alpha = 0.8
        rainLabel.textColor = .black
        
        return rainLabel
    }()
    
    private lazy var pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.font = pressureLabel.font.withSize(17)
        pressureLabel.alpha = 0.8
        pressureLabel.textColor = .black
        
        return pressureLabel
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let feelsLikeLabel = UILabel()
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.alpha = 0.8
        feelsLikeLabel.textColor = .red
        feelsLikeLabel.font = .boldSystemFont(ofSize: 11)
        
        return feelsLikeLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = dateLabel.font.withSize(17)
        dateLabel.alpha = 0.8
        dateLabel.textColor = .black
        
        return dateLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = descriptionLabel.font.withSize(17)
        descriptionLabel.alpha = 0.8
        descriptionLabel.textColor = .black
        
        return descriptionLabel
    }()
    
    private lazy var temperatureNightLabel: UILabel = {
        let temperatureNightLabel = UILabel()
        temperatureNightLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureNightLabel.textColor = .black
        temperatureNightLabel.font = .boldSystemFont(ofSize: 17)
        
        return temperatureNightLabel
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setupWithModel(model: WeatherModel) {
        dateLabel.text = model.date.convertDate(dateFormat: "MM.dd.yyyy, EEEE" )
        descriptionLabel.text = model.description
        rainLabel.text = "\(model.rain) мм"
        windLabel.text = "ветер  \(model.wind) м/с"
        pressureLabel.text = "давление \(model.pressure) гПа"
        feelsLikeLabel.text = "ощущается \(Int(model.feelsLike))°C"
        temperatureDayLabel.text = " \(Int(model.temperatureDay))°C"
        imageView.image = model.weatherStateImage
        temperatureNightLabel.text = "температура ночью \(Int(model.temperatureNight))°C"
    }
}

// MARK: - WeatherCell

private extension WeatherCell {
    func setupViews() {
        addViews()
        setupLayoutDateLabel()
        setupLayoutDescriptionLabel()
        setupLayoutRainLabel()
        setupLayoutWindLabel()
        setupLayoutPressureLabel()
        setupLayoutImageView()
        setupLayoutTemperaturDayLabel()
        setupLayoutTemperaturNightLabel()
        setupLayoutFeelsLikeLabel()
    }
    
    func addViews() {
        contentView.addSubview(rainLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(pressureLabel)
        contentView.addSubview(feelsLikeLabel)
        contentView.addSubview(temperatureDayLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(temperatureNightLabel)
    }
    
    func setupLayoutDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
    
    func setupLayoutDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
        ])
    }
    
    func setupLayoutRainLabel() {
        NSLayoutConstraint.activate([
            rainLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            rainLabel.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 5)
        ])
    }
    
    func setupLayoutWindLabel() {
        NSLayoutConstraint.activate([
            windLabel.topAnchor.constraint(equalTo: rainLabel.bottomAnchor, constant: 10),
            windLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
    
    func setupLayoutPressureLabel() {
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 10),
            pressureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
    
    func setupLayoutImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            imageView.heightAnchor.constraint(equalToConstant: 35),
            imageView.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func setupLayoutTemperaturDayLabel() {
        NSLayoutConstraint.activate([
            temperatureDayLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            temperatureDayLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -35)
        ])
    }
    
    func setupLayoutFeelsLikeLabel() {
        NSLayoutConstraint.activate([
            feelsLikeLabel.topAnchor.constraint(equalTo: temperatureDayLabel.bottomAnchor, constant: 5),
            feelsLikeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
    
    func setupLayoutTemperaturNightLabel() {
        NSLayoutConstraint.activate([
            temperatureNightLabel.topAnchor.constraint(equalTo: pressureLabel.topAnchor, constant: 30),
            temperatureNightLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
}

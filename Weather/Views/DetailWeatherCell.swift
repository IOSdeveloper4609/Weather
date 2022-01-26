//
//  DetailWeatherCell.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import UIKit

final class DetailWeatherCell: BaseCell {
    
    // MARK: - Private properties
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .boldSystemFont(ofSize: 17)
        dateLabel.textColor = .black
        
        return dateLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        descriptionLabel.font = .boldSystemFont(ofSize: 17)
        
        return descriptionLabel
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
    
    func setupWithModel(model: CommonModel) {
        dateLabel.text = model.date.convertDate(dateFormat: "MM.dd.yyyy E. HH:mm" )
        descriptionLabel.text = model.description
        temperatureDayLabel.text = " \(Int(model.temperatureDay))°C"
        imageView.image = model.weatherStateImage
    }
}

// MARK: - DetailWeatherCell

private extension DetailWeatherCell {
    func setupViews() {
        addViews()
        setupLayoutDateLabel()
        setupLayoutTemperaturDayLabel()
        setupLayoutImageView()
        setupLayoutDescriptionLabel()
    }
    
    func addViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(temperatureDayLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    func setupLayoutDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
    
    func setupLayoutTemperaturDayLabel() {
        NSLayoutConstraint.activate([
            temperatureDayLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7),
            temperatureDayLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        ])
    }
    
    func setupLayoutImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupLayoutDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
        ])
    }
}







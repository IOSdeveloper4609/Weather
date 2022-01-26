//
//  BaseCell.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import UIKit

class BaseCell: UICollectionViewCell {
 
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private(set) lazy var temperatureDayLabel: UILabel = {
        let temperatureDayLabel = UILabel()
        temperatureDayLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureDayLabel.font = .boldSystemFont(ofSize: 24)
        temperatureDayLabel.textColor = .cyan
        
        return temperatureDayLabel
    }()
    
    static var Identifier: String {
        String(describing: type(of: self))
    }
    
     func setupCell() {
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

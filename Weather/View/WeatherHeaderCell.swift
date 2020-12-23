//
//  WeatherHeaderCell.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/23.
//

import UIKit

class WeatherHeaderCell: UITableViewCell {
    
    // MARK: - Propertise
    static let identifier = "WeatherHeaderCell"
    
    var textArr: [String]? {
        didSet {
            configure()
        }
    }
    
    private let titleLabel = UILabel()
    private let todayLabel = UILabel()
    private let tomorrowLabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherHeaderCell {
    private func setUI() {
        [titleLabel, todayLabel, tomorrowLabel].forEach {
            contentView.addSubview($0)
            $0.textAlignment = .center
            
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 10)
        todayLabel.font = UIFont.boldSystemFont(ofSize: 15)
        tomorrowLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.layer.borderWidth = 1
        todayLabel.layer.borderWidth = 1
        tomorrowLabel.layer.borderWidth = 1
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        todayLabel.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(0.45)
        }
        
        tomorrowLabel.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.leading.equalTo(todayLabel.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(0.45)
        }
    }
    
    func configure() {
        titleLabel.text = textArr?[0]
        todayLabel.text = textArr?[1]
        tomorrowLabel.text = textArr?[2]
    }
}


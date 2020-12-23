//
//  WeatherCell.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/22.
//

import UIKit
import SnapKit
import SDWebImage

class WeatherCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "WeatherCell"
    
    var todayLocalWeather: consolidated_weather?
    var tomorrowLocalWeather: consolidated_weather? {
        didSet {
            setToday()
            setTomorrow()
        }
    }
    
    private let localTitle = UILabel()
    
    private lazy var tomorrowView = CustomView(img: tomorrowLocalWeather!.weather_state_abbr,
                                               state: tomorrowLocalWeather!.weather_state_name,
                                               temp: tomorrowLocalWeather!.the_temp,
                                               humidity: tomorrowLocalWeather!.humidity)
    
    private lazy var todayView = CustomView(img: todayLocalWeather!.weather_state_abbr,
                                            state: todayLocalWeather!.weather_state_name,
                                            temp: todayLocalWeather!.the_temp,
                                            humidity: todayLocalWeather!.humidity)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TitleConfigure
extension WeatherCell {
    func localTitleConfigure(title: String) {
        localTitle.text = title
    }
}

// MARK: - setUI
extension WeatherCell {
    
    private func setToday() {
        contentView.addSubview(todayView)
        
        todayView.layer.borderWidth = 1
        
        todayView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.leading.equalTo(localTitle.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(0.45)
        }
    }
    
    private func setTomorrow() {
        contentView.addSubview(tomorrowView)
        
        tomorrowView.layer.borderWidth = 1
        
        tomorrowView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.leading.equalTo(todayView.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(0.45)
        }
    }
    
    private func setUI() {
        contentView.addSubview(localTitle)
        
        localTitle.font = UIFont.systemFont(ofSize: 10)
        localTitle.textAlignment = .center
        localTitle.numberOfLines = 0
        localTitle.layer.borderWidth = 1
        
        localTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        
    }
    
}

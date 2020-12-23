//
//  CustomView.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/24.
//

import UIKit

class CustomView: UIView {
    
    private let localWeatherImage = UIImageView()
    private let weatherStateNameLabel = UILabel()
    private let weatherTempLabel = UILabel()
    private let humidityLabel = UILabel()
    
    init(img: String, state: String, temp: Double, humidity: Int) {
        super.init(frame: .zero)
        [localWeatherImage, weatherStateNameLabel, weatherTempLabel, humidityLabel].forEach {
            self.addSubview($0)
        }
        
        localWeatherImage.contentMode = .scaleAspectFill
        localWeatherImage.clipsToBounds = true
        
        localWeatherImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(65)
        }
        
        weatherStateNameLabel.font = UIFont.systemFont(ofSize: 13)
        weatherStateNameLabel.textAlignment = .center
        
        weatherStateNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-10)
            $0.leading.equalTo(localWeatherImage.snp.trailing).offset(8)
        }
        
        weatherTempLabel.textColor = .red
        weatherTempLabel.textAlignment = .center
        weatherTempLabel.font = UIFont.systemFont(ofSize: 12)
        
        weatherTempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherStateNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(weatherStateNameLabel)
        }
        
        humidityLabel.textAlignment = .center
        humidityLabel.font = UIFont.systemFont(ofSize: 12)
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(weatherStateNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(weatherTempLabel.snp.trailing).offset(8)
        }
        
        weatherStateNameLabel.text = state
        let tempFloor = Int(floor(temp))
        weatherTempLabel.text = "\(tempFloor)℃"
        humidityLabel.text = "\(humidity)％"
        
        guard let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(img).png") else { return }
        localWeatherImage.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

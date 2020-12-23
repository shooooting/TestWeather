//
//  WeatherHeaderView.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/22.
//

import UIKit

class WeatherHeaderView: UIView {
    
    // MARK: - Propertise
    private let titleLabel = UILabel()
    private let todayLabel = UILabel()
    private let tomorrowLabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setUI

extension WeatherHeaderView {
    private func setUI() {
        
        titleLabel.text = "Local"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        todayLabel.text = "Today"
        todayLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        tomorrowLabel.text = "Tomorrow"
        tomorrowLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, todayLabel, tomorrowLabel])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.layer.borderWidth = 1
        addSubview(stack)
        
        stack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
}

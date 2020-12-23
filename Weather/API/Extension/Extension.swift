//
//  Extension.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/24.
//

import UIKit

extension UIViewController {
    
    static let indicate = UIActivityIndicatorView()
    
    static let indicateView: UIView = {
        let view = UIView()
        let indicate = UIViewController.indicate
        indicate.hidesWhenStopped = true
        indicate.style = .large
        indicate.color = .white

        view.addSubview(indicate)
        indicate.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.center.equalToSuperview()
        }

        view.isHidden = true
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    func showIndicate() {
        self.view.addSubview(UIViewController.indicateView)
        UIViewController.indicateView.isHidden = false
        UIViewController.indicateView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        UIViewController.indicate.startAnimating()
    }

    func stopIndicate() {
        UIViewController.indicateView.isHidden = true
        UIViewController.indicate.stopAnimating()
    }
    
}

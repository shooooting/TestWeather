//
//  ViewController.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var titleArr: [String]?
    var local: [Local]?
    var weather = [Weather]() {
        didSet {
            if weather.count == local!.count {
                DispatchQueue.main.async {
                    self.stopIndicate()
                    self.setTableView()
                    self.tableView.reloadData()
                    self.titleArr = ["Local", "Today", "Tomorrow"]
                }
            }
        }
    }
    
    private let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        localAPI()
        setNavigation()
        tableviewRefresh()
        self.showIndicate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

// MARK: - Action
extension ViewController {
    private func tableviewRefresh() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc
    private func refreshTableView() {
        local?.removeAll()
        weather.removeAll()
        titleArr?.removeAll()
        DispatchQueue.main.async {
            self.localAPI()
            self.showIndicate()
        }
        self.tableView.isHidden = true
        
    }
}

// MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate {
    
}

// MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource {
    enum CategoryType: Int, CaseIterable {
        case Header
        case Weather
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CategoryType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch CategoryType(rawValue: section)! {
        case .Header:
            return 1
        case .Weather:
            return local?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CategoryType(rawValue: indexPath.section) {
        case .Header:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHeaderCell.identifier, for: indexPath) as! WeatherHeaderCell
            cell.selectionStyle = .none
            if self.local?.count == self.weather.count {
                cell.textArr = titleArr
                return cell
            }
            return UITableViewCell()
        case .Weather:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
            cell.selectionStyle = .none
            if self.local?.count == self.weather.count {
                cell.localTitleConfigure(title: weather[indexPath.row].title)
                cell.todayLocalWeather = weather[indexPath.row].consolidated_weather[0]
                cell.tomorrowLocalWeather = weather[indexPath.row].consolidated_weather[1]
            }
            self.tableView.isHidden = false
            self.tableView.refreshControl?.endRefreshing()
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch CategoryType(rawValue: indexPath.section)! {
        case .Header:
            return 40
        case .Weather:
            return 100
        }
    }
}

// MARK: - API
extension ViewController {
    private func localAPI() {
        localAPI { data in
            self.local = data
            for i in 0...self.local!.count - 1 {
                //                print(i, self.local![i].woeid)
                self.localWeather(location: self.local![i].woeid) { data in
                    self.weather.append(data)
                }
            }
        }
    }
}

// MARK: - TableView
extension ViewController {
    
    private func setTableView() {
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        tableView.register(WeatherHeaderCell.self, forCellReuseIdentifier: WeatherHeaderCell.identifier)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
}

// MARK: - Navigation
extension ViewController {
    
    private func setNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .purple
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Local Weather"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
}

//
//  DetailViewController.swift
//  Rates
//
//  Created by Александр on 16.12.2020.
//

import UIKit

class FirstValuesViewController: UIViewController {
    
    let generalView = GeneralView()
    private var arrayKeys = [String]()
    var rate:RatesModel!
    var value = "USD"
    private let reuseIdentifierTableView = "DetailCellTableView"
    weak var generalVC: GeneralViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetch()
    }
    
    // MARK: - SetupUI
    
    private func setupUI(){
        view.addSubview(generalView)
        view.backgroundColor = .white
        
        generalView.pin.all()
        
        generalView.tableView.delegate = self
        generalView.tableView.dataSource = self
        generalView.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
        navigationItem.title = "First currency"
    }
    
    // MARK: - Fetch request
    
    func fetch(){
        generalView.activityIndicator.startAnimating()
        fetchData(value: self.value) { (result) in
            switch result {
            case .success(let data):
                self.rate = data
                for (key, _) in self.rate.rates! {
                    self.arrayKeys.append(key)
                }
                self.generalView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        generalView.activityIndicator.stopAnimating()
    }
}

// MARK: - Extension of TableView

extension FirstValuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rate?.rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! DetailTableViewCell
        cell.nameValue.text = arrayKeys[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = arrayKeys[indexPath.row]
        let vc = SecondValuesViewController(key: key)
        vc.delegate = generalVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

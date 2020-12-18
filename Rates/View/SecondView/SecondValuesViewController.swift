//
//  SecondValueViewController.swift
//  Rates
//
//  Created by Александр on 16.12.2020.
//

import UIKit

protocol SecondViewControllerDelegate: class {
    func add(key:String, secKey:String, secValue: Double)
}

class SecondValuesViewController: UIViewController {
    
    let generalView = GeneralView()
    private var arrayKeys = [String]()
    private var arrayValue = [Double]()
    var rate:RatesModel!
    var key = ""
    private let reuseIdentifierTableView = "DetailCellTableView"
    weak var delegate:SecondViewControllerDelegate?
    
    init(key: String) {
        self.key = key
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationItem.title = "Second currency"
    }
    
    // MARK: - Fetch request
    
    func fetch(){
        generalView.activityIndicator.startAnimating()
        fetchData(value: self.key) { (result) in
            switch result {
            case .success(let data):
                self.rate = data
                self.fetchKeys()
                self.generalView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        generalView.activityIndicator.stopAnimating()
    }
    
    // MARK: - Splitting by keys and values
    
    func fetchKeys() {
        for (key, value) in rate.rates! {
            arrayKeys.append(key)
            arrayValue.append(value)
        }
    }
}

// MARK: - Extension of TableView

extension SecondValuesViewController: UITableViewDelegate, UITableViewDataSource {
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
        delegate?.add(key: self.key, secKey: arrayKeys[indexPath.row], secValue: arrayValue[indexPath.row])
        navigationController?.popToRootViewController(animated: true)
    }
}

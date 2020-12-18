//
//  ViewController.swift
//  Rates
//
//  Created by Александр on 15.12.2020.
//

import UIKit
import PinLayout
import CoreData


class GeneralViewController: UIViewController, SecondViewControllerDelegate {
    
    let generalView = GeneralView()
    private var currencyArray:[Currencys] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    private let reuseIdentifierTableView = "CellTableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - SetupUI
    
    private func setupUI(){
        view.addSubview(generalView)
        view.backgroundColor = .white
        
        generalView.pin.all()
        
        generalView.tableView.delegate = self
        generalView.tableView.dataSource = self
        generalView.tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
        navigationItem.title = "Rates"
    }
    
    // MARK: - Work with CoreDate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Currencys> = Currencys.fetchRequest()
        
        do {
            currencyArray = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func saveData(key: String, secKey: String, secValue: String) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Currencys", in: context) else {return}
        
        let taskObject = Currencys(entity: entity, insertInto: context)
        taskObject.firstValue = key
        taskObject.secondValue = secValue
        taskObject.secondRate = secKey
        
        do {
            self.currencyArray.insert(taskObject, at: 0)
            try context.save()
            generalView.tableView.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        print(self.currencyArray.count)
    }
    
    private func deleteData(for indexPath:IndexPath) {
        
        context.delete(currencyArray[indexPath.row])
        generalView.tableView.reloadData()
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Receive and save data
    
    func add(key: String, secKey: String, secValue: Double) {
        saveData(key: key, secKey: secKey, secValue: String(round(secValue*100)/100))
        generalView.tableView.reloadData()
    }
    
    
    // MARK: - Push to next ViewController
    @objc func addTapped() {
        let vc = FirstValuesViewController()
        vc.generalVC = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension of TableView

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! GeneralTableViewCell
        let data = currencyArray[indexPath.row]
        cell.firstValue.text = "1 \(data.firstValue ?? "")"
        cell.secondValue.text = data.secondValue
        cell.secondRate.text = data.secondRate
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            deleteData(for: indexPath)
            currencyArray.remove(at: indexPath.row)
            generalView.tableView.reloadData()
        }
    }
}


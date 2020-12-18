//
//  GeneralView.swift
//  Rates
//
//  Created by Александр on 15.12.2020.
//

import UIKit
import PinLayout

class GeneralView: UIView {
    
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(tableView)
        addSubview(activityIndicator)
        
        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all(pin.safeArea)
        activityIndicator.pin.hCenter().vCenter().height(50).width(50)
    }
}

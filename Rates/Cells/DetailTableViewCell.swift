//
//  DetailViewCell.swift
//  Rates
//
//  Created by Александр on 16.12.2020.
//

import UIKit
import PinLayout

class DetailTableViewCell: UITableViewCell {

    var nameValue = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        addSubview(nameValue)
        
        nameValue.font = UIFont(name: "Helvetica", size: 32)
        nameValue.textAlignment = .center
        nameValue.pin.hCenter().vCenter().height(100).width(100)
       
        self.layer.cornerRadius = 5
        self.separatorInset = UIEdgeInsets.init(top: 0.0, left: 25.0, bottom: 0.0, right: 25.0)
        self.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 100.0, bottom: 0.0, right: 0.0)
    }
}

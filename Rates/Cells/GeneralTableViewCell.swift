//
//  TableViewCell.swift
//  Rates
//
//  Created by Александр on 15.12.2020.
//

import UIKit
import PinLayout

class GeneralTableViewCell: UITableViewCell {
    
    var firstValue = UILabel()
    var secondValue = UILabel()
    var secondRate = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        addSubview(firstValue)
        addSubview(secondValue)
        addSubview(secondRate)
        
        secondValue.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        secondRate.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        firstValue.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        
        firstValue.pin.top(15).left(30).width(100).height(50)
        secondValue.pin.top(15).width(130).height(50).right(0)
        secondRate.pin.right(30).below(of: secondValue).marginTop(2).width(100).height(15)
        
        self.layer.cornerRadius = 5
        self.separatorInset = UIEdgeInsets.init(top: 0.0, left: 25.0, bottom: 0.0, right: 25.0)
        self.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 100.0, bottom: 0.0, right: 0.0)
    }
}

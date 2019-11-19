//
//  VolunteerTableViewCell.swift
//  greenr
//
//  Created by Chloe Yan on 10/29/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import Foundation
import UIKit

class VolunteerTableViewCell: UITableViewCell {
    static let identifier = "volunteerCell"
    
    lazy var backView: UIView = {
        let vtVC = VolunteerTableViewController()
        let view = UIView(frame: CGRect(x: 12, y: 3, width: vtVC.view.bounds.maxX-30, height: 90))
        view.backgroundColor = UIColor(red:0.61, green:0.74, blue:0.49, alpha:1.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        
        view.translatesAutoresizingMaskIntoConstraints = true
        view.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        
        return view
     } ()

     lazy var volunteerEventLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 19, y: 5, width: backView.bounds.width*0.9, height: 75))
         label.numberOfLines = 0
         label.textAlignment = .left
         label.textColor = UIColor.white
         label.font = UIFont(name: "Poppins-Regular", size: 18)
         return label
     }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(volunteerEventLabel)
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 12
        backView.clipsToBounds = true
    }
}

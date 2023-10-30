//
//  OfferCell.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 24..
//

import UIKit

class OfferCell: UITableViewCell {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedBackgroundView = UIView()
        roundedView.layer.cornerRadius = 10
        
        roundedView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOpacity = 0.25
        roundedView.layer.shadowRadius = 4
    }
}

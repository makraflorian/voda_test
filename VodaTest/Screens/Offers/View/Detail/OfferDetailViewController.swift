//
//  OfferDetailViewController.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 29..
//

import UIKit

class OfferDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    var viewModel: OfferDetailViewModel = OfferDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true

        viewModel.name.bind {
            self.nameLabel.text = $0
            self.title = $0
        }
        viewModel.shortDescription.bind {
            self.shortDescriptionLabel.text = $0
        }
        viewModel.longDescription.bind {
            self.descriptionLabel.text = $0
        }
        
        viewModel.showAlert.bind {
            if $0 {
                let alert = UIAlertController(title: "Error", message: "Unable to fetch data", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)                
            }
        }

        viewModel.getOfferDetail()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.getOfferDetail()
        refreshControl.endRefreshing()
    }
}

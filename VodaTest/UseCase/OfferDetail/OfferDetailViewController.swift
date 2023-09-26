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
    
    var viewModel: OfferDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        
        viewModel?.itemViewModel.bind {
            self.setupLabels(item: $0)
        }
        
        viewModel?.showAlert.bind {
            if $0 {
                let alert = UIAlertController(title: "Error", message: "Unable to fetch data", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        viewModel?.getOfferDetail()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    func setupLabels(item: OfferDetailItemViewModel) {
        title = item.name
        nameLabel.text = item.name
        shortDescriptionLabel.text = item.shortDescription
        descriptionLabel.text = item.description
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel?.getOfferDetail()
        refreshControl.endRefreshing()
    }
}

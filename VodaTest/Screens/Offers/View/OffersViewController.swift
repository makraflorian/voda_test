//
//  OffersViewController.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 24..
//

import UIKit

class OffersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var viewModel = {
        OffersViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Offers"
        initViewModel()
    }
    
    func initViewModel() {
        print("INIT brr")
        viewModel.getOffers()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OFFER_CELL_ID", for: indexPath) as! OfferCell
        let offer = viewModel.offers[indexPath.row]
        cell.titleLabel.text = offer.name
        cell.descriptionLabel.text = offer.shortDescription
        
        return cell
    }
    
}


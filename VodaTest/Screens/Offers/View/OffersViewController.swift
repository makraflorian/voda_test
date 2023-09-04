//
//  OffersViewController.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 24..
//

import UIKit

class OffersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let offerSegueIdentifier = "ShowOfferSegue"
    
    var viewModel: OffersViewModel = OffersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Offers"
        
        viewModel.offersGroups.bind {_ in
            self.tableView.reloadData()
        }
        
        viewModel.getOffers()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.getOffers()
        refreshControl.endRefreshing()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.offersGroups.value[section].offers.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.offersGroups.value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.offersGroups.value[section].name
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 0, width: headerView.frame.width-16, height: headerView.frame.height-16)
        label.text = viewModel.offersGroups.value[section].name
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = .black
            
            headerView.addSubview(label)
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OFFER_CELL_ID", for: indexPath) as! OfferCell
        let offer = viewModel.offersGroups.value[indexPath.section].offers[indexPath.row]
        cell.titleLabel.text = offer.name
        cell.descriptionLabel.text = offer.shortDescription
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        //        if  segue.identifier == offerSegueIdentifier {
        //            _ = segue.destination as! OfferDetailViewController
        let destination = segue.destination as! OfferDetailViewController
        let offerIndex = tableView.indexPathForSelectedRow?.row
        destination.viewModel.offerId = viewModel.offers[offerIndex!].id
        
        //        }
    }
}


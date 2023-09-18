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
    
    var viewModel: OffersViewModel = OffersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Offers"
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0);
        
        viewModel.offersGroups.bind {_ in
            self.tableView.reloadData()
        }
        
        viewModel.showAlert.bind {
            if $0 {
                let alert = UIAlertController(title: "Error", message: "Unable to fetch data", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.text =  header.textLabel?.text?.capitalized
        header.textLabel?.frame = header.bounds
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
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
        let destination = segue.destination as! OfferDetailViewController
        let offerIndex = tableView.indexPathForSelectedRow?.row
        destination.viewModel.offerId = viewModel.offers[offerIndex!].id
    }
}


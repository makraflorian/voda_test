//
//  OffersViewController.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 24..
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class OffersViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var pullToRefresh: UIRefreshControl = .init()
    let disposeBag = DisposeBag()
    
    var viewModel: OffersViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Offers"
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        pullToRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.refreshControl = pullToRefresh
        
        configurePullToRefresh()
        
        let dataSource = RxTableViewSectionedReloadDataSource<OfferTypeModel>(
            configureCell: { _, tableView, indexPath, item in
                // swiftlint:disable:next force_cast
                let cell = tableView.dequeueReusableCell(withIdentifier: "OFFER_CELL_ID", for: indexPath) as! OfferCell
                cell.titleLabel?.text = item.name
                cell.descriptionLabel?.text = item.shortDescription
                return cell
            })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].name
        }
        
        viewModel?.offersGroups.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        viewModel?.offersGroups.subscribe {
            if $0[0].errorState {
                let alert = UIAlertController(title: "Error", message: "Unable to fetch data",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }.disposed(by: disposeBag)
        
        viewModel?.refreshRelay.refresh(true)
    }
    
    func configurePullToRefresh() {
        pullToRefresh.rx
            .controlEvent(.valueChanged)
            .subscribe { [weak self] event in
                guard let self = self, case .next = event else { return }
                self.viewModel?.refreshRelay.refresh(false)
            }.disposed(by: disposeBag)
        
        viewModel?.offersGroups
            .subscribe { [weak self] event in
                print(event)
                guard let self = self else { return }
                self.pullToRefresh.endRefreshing()
            }.disposed(by: disposeBag)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}

//
//  OfferDetailViewController.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 29..
//

import UIKit
import RxSwift
import RxCocoa

class OfferDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    var pullToRefresh: UIRefreshControl = .init()
    let disposeBag = DisposeBag()
    
    var viewModel: OfferDetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        pullToRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        scrollView.refreshControl = pullToRefresh
        
        configurePullToRefresh()
        
        viewModel?.itemViewModel.subscribe { [weak self] item in
            guard let self = self else { return }
            self.setupLabels(item: item)
        }.disposed(by: disposeBag)
        
        viewModel?.refreshRelay.refresh(true)
    }
    
    func setupLabels(item: OfferDetailItemViewModel) {
        title = item.name
        nameLabel.text = item.name
        shortDescriptionLabel.text = item.shortDescription
        descriptionLabel.text = item.description
        
        if item.errorState! {
            let alert = UIAlertController(title: "Error", message: "Unable to fetch data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func configurePullToRefresh() {
        pullToRefresh.rx
            .controlEvent(.valueChanged)
            .subscribe { [weak self] event in
                guard let self = self, case .next = event else { return }
                self.viewModel?.refreshRelay.refresh(false)
            }.disposed(by: disposeBag)
        
        viewModel?.itemViewModel
            .subscribe { [weak self] event in
                print(event)
                guard let self = self else { return }
                self.pullToRefresh.endRefreshing()
            }.disposed(by: disposeBag)
    }
}

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
    
    lazy var viewModel = {
        OfferDetailViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        print(viewModel.offerId)
        //        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
        title = viewModel.offer?.name
        nameLabel.text = viewModel.offer?.name
        shortDescriptionLabel.text = viewModel.offer?.shortDescription
        descriptionLabel.text = viewModel.offer?.description
        // Do any additional setup after loading the view.
    }
    
    func initViewModel() {
        print("INIT brr")
        viewModel.getOfferDetail()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

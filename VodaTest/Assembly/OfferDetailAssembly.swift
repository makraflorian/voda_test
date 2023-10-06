//
//  OfferDetailAssembly.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 21..
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

internal class OfferDetailAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(OfferDetailViewModelType.self, initializer: OfferDetailViewModel.init).inObjectScope(.container)
        container.storyboardInitCompleted(OfferDetailViewController.self, initCompleted: { r, c in
            c.viewModel = r.resolve(OfferDetailViewModelType.self)!
        })
    }
}

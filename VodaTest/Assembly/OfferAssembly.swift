//
//  OfferAssembly.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 21..
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

internal class OffersAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(OffersViewModel.self, initializer: OffersViewModel.init).inObjectScope(.container)
        container.storyboardInitCompleted(OffersViewController.self, initCompleted: { r, c in
            c.viewModel = r.resolve(OffersViewModel.self)!
        })
    }
}

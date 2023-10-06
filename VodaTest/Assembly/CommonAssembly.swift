//
//  CommonAssembly.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 25..
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

internal class CommonAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(NetworkManagerType.self, initializer: NetworkManager.init).inObjectScope(.container)
        container.autoregister(OfferInteractorType.self, initializer: OfferInteractor.init).inObjectScope(.container)

    }
}

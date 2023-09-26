//
//  NetworkManagerAssembly.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 25..
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

internal class NetworkManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkManager.self) { _ in 
            return NetworkManager()
        }.inObjectScope(.container)
    }
}

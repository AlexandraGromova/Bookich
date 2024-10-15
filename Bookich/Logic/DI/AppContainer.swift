//
//  AppContainer.swift
//  Bookich
//
//  Created by Sasha on 15.10.2024.
//

import Foundation
import Swinject

class AppContainer {
    
    static private let container = Container()
    
    static func setup() {
        container.register(AuthVM.self) { r in
            AuthVM()
        }
    }
    
    static func resolve<T>(_ serviceType: T.Type) -> T {
        return container.resolve(serviceType)!
    }
}

//
//  Resolver+Exxtension.swift
//  Notes
//
//  Created by Egor Evseenko on 23.12.2024.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerServices()
    }
}

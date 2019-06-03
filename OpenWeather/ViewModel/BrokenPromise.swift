//
//  BrokenPromise.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/02.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation
import PromiseKit

func brokenPromise<T>(method: String = #function) -> Promise<T> {
    return Promise<T>() { seal in
        let err = NSError(domain: "OpenWeather", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' not yet implemented."])
        seal.reject(err)
    }
}

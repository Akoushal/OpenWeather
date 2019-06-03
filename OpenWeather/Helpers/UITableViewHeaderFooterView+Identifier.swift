//
//  UITableViewHeaderFooterView+Identifier.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/01.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

extension UITableViewHeaderFooterView {
    static var uniqueIdentifier: String {
        return String(describing: self)
    }
}

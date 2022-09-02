//
//  QWUtility.swift
//  QWarySurvey
//
//  Created by fahid on 02/09/2022.
//

import Foundation
import UIKit

public extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

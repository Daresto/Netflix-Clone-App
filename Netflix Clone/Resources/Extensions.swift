//
//  Extensions.swift
//  Netflix Clone
//
//  Created by  Abdurahmon on 22/09/22.
//

import Foundation

extension String {
    func capitalizedString() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

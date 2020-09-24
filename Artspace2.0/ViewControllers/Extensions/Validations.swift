//
//  Validations.swift
//  Artspace2.0
//
//  Created by Kary Martinez on 9/22/20.
//  Copyright © 2020 Artspace. All rights reserved.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let validEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", validEmailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    var isValidPassword: Bool {
        let validPasswordRegEx = "[A-Z0-9a-z!@#$&*.-]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", validPasswordRegEx)
        return passwordPredicate.evaluate(with: self)
    }
}

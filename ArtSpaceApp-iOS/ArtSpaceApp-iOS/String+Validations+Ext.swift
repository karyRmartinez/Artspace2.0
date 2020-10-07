//
//  String+Validations+Ext.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import Foundation

extension String {
  var isValidEmail: Bool {
    // this pattern requires that an email use the following format:
    // [something]@[some domain].[some tld]
    let validEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", validEmailRegEx)
    return emailPredicate.evaluate(with: self)
  }
}

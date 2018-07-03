//
//  LoginModel.swift
//  Tesla
//
//  Created by Ronan on 7/2/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import Foundation

// china
// cn
// +86
struct CountryModel {
    let englishName: String
    let abbriviation: String
    let code: String
}

struct LoginModel {
    let splashName: String
    let title: String
    let country: CountryModel
    let numberPlaceholder: String
    let nextName: String
    let alternativeText: String
}

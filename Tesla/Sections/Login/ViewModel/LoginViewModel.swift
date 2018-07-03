//
//  LoginViewModel.swift
//  Tesla
//
//  Created by Ronan on 7/1/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

struct LoginViewModel {
    
    var  model: LoginModel
    
    var splashImage: UIImage? {
        return UIImage(named: model.splashName)
    }
    
    var title: String {
        return model.title
    }
    
    var countryFlag: UIImage? {
        return UIImage(named: "flag_" + model.country.abbriviation)
    }
    
    var countryCode: String {
        return model.country.code
    }
    
    var numberPlaceholder: String {
        return model.numberPlaceholder
    }
    
    var nextImage: UIImage? {
        return UIImage(named: model.nextName)
    }
    
    var alternativeText: String {
        return model.alternativeText
    }
    
}


//struct CountryModel {
//    let countryName: String
//    let countryFlag: String
//}
//
//struct LoginModel {
//    let splashName: String
//    let title: String
//    let defaultCountry: CountryModel
//    let numberPlaceholder: String
//    let alternativeText: String
//}

//
//  UITableView.swift
//  Tesla
//
//  Created by Ronan on 6/29/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

extension UITableView {
    // 注册 cell
    func rb_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCell {
        register(cell, forCellReuseIdentifier: T.identifier)
    }
    
    // 重用  cell
    func rb_dequeReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCell {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

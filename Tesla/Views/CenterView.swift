//
//  CenterView.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum ButtonItemState {
    case normal
    case selected
}

struct ButtonItem {
    var normalImage: String
    var normalText: String
    var selectedImage: String
    var selectedText: String
}

class CenterView: UIView {
    
    let margin: CGFloat = 20
    let marginCompact: CGFloat = 10
    let buttonRadius: CGFloat = 56
    
    let bag = DisposeBag()
    
    convenience init(frame: CGRect, items: [ButtonItem]) {
        self.init(frame: frame)
        setupSubviews(items)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 添加子视图
    fileprivate func setupSubviews(_ items: [ButtonItem]) {
        let spacing = self.bounds.width / CGFloat(items.count)
        for item in items {
            let button = UIButton()
            addSubview(button)
            button.snp.makeConstraints { make in
                make.top.equalTo(margin)
                make.left.right.equalTo(spacing)
                make.size.equalTo(buttonRadius)
            }
            button.setImage(UIImage(named: item.normalImage), for: .normal)
            button.setTitle(item.normalText, for: .normal)
            button.setImage(UIImage(named: item.selectedImage), for: .selected)
            button.setTitle(item.selectedText, for: .selected)
            button.rx.tap
                .subscribe(onNext: {
                    if button.isSelected {
                        print("取消选中")
                    }
                    else {
                        print("改成选中")
                    }
                    button.isSelected = !button.isEnabled
                })
                .disposed(by: bag)

            let label = UILabel()
            addSubview(label)
            label.snp.makeConstraints { make in
                make.centerX.equalTo(button)
                make.top.equalTo(button).offset(marginCompact)
            }
            
        }
    }
    
    func toggle() {
        
    }
    
    
}

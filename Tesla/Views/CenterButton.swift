//
//  CenterButton.swift
//  Tesla
//
//  Created by Ronan on 6/28/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ButtonContent {
    var normalImage: String
    var normalText: String
    var selectedImage: String
    var selectedText: String
//    var state: ButtonItemState
}

class CenterButton: UIButton {

    let bag = DisposeBag()
    
    convenience init(frame: CGRect, content: ButtonContent) {
        self.init(frame: frame)
        
        setupContent(content: content)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupContent(content: ButtonContent) {
        self.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.isSelected = !self.isSelected
            })
            .disposed(by: bag)
        setImage(UIImage(named: content.normalImage), for: .normal)
        setImage(UIImage(named: content.selectedImage), for: .selected)
        setTitleColor(UIColor.themeDarkGray(), for: .normal)
        setTitleColor(UIColor.themeGreen(), for: .selected)
        setTitle(content.normalText, for: .normal)
        setTitle(content.selectedText, for: .selected)
        titleLabel?.font = UIFont.setGotham(.body)
        imageView?.contentMode = .scaleAspectFit
        imageView?.frame.size = CGSize(width: UNIVERSAL_RADIUS, height: UNIVERSAL_RADIUS)
    }
    
    // 图片在上、文字在写
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var imageCenter = imageView!.center
        imageCenter.x = frame.size.width / 2
        imageCenter.y = frame.size.height / 2
        imageView?.center = imageCenter
        
        var newFrame = titleLabel!.frame
        newFrame.origin.x = 0
        newFrame.origin.y = imageView!.frame.size.height + 10
        newFrame.size.width = frame.size.width
        
        titleLabel?.frame = newFrame
        titleLabel?.textAlignment = .center
        
    }
}

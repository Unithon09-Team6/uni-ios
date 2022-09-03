//
//  UITextField+.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/04.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addRightPadding(width: CGFloat = 50) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
        paddingView.isUserInteractionEnabled = false
    }
}

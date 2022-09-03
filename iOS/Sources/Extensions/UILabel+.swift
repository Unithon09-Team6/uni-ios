//
//  UILabel+.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UILabel {
    
    func timerToString(_ countDown: Int) -> PublishRelay<Int> {
        let nowCount = PublishRelay<Int>()
        let countDown = countDown
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
                .take(countDown+1)
                .subscribe(onNext: { timePassed in
                    let count = countDown - timePassed
                    nowCount.accept(count)
                    print(count)
                }, onCompleted: {
                    print("onCompleted")
                })
                .disposed(by: Const.disposeBag)
        return nowCount
    }
    
    /// UILabel 행간설정
    func setLineSpacing(lineSpacing: CGFloat) {
        if let text = self.text {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributedStr.length))
            self.attributedText = attributedStr
        }
    }
    
    func setLineSpacingWithChaining(lineSpacing: CGFloat) -> UILabel {
        let label = self
        if let text = self.text {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style
            ]
            label.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
        return label
    }

}

//timerToString(20)
//    .bind { int in
//        self.timerlabel.text = "\(int)"
//    }
//    .disposed(by: disposeBag)

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

}

//timerToString(20)
//    .bind { int in
//        self.timerlabel.text = "\(int)"
//    }
//    .disposed(by: disposeBag)

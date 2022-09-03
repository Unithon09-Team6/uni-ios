//
//  TimerVC.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class TimerVC: BaseViewController {

    fileprivate let isRunningFirst: BehaviorRelay = BehaviorRelay(value: false)
    fileprivate var isRunningSecond: Bool = false

    private let timerlabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40)
        $0.textColor = .label
        $0.textAlignment = .center
        $0.text = "dddd"
    }

    override func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(timerlabel)
    }

    override func setupConstraints() {
        timerlabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    let timePassed = 0

    override func bind() {
        let countDown = 15 // 15 seconds
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
                .take(countDown+1)
                .subscribe(onNext: { timePassed in
                    let count = countDown - timePassed
                    self.timerlabel.text = "타이머2: \(count)초"
                    print(count)
                }, onCompleted: {
                    self.timerlabel.text = "다음 단계로 넘어가 주세요"
                })
        }
}

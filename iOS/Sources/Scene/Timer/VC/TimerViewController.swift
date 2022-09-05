//
//  TimerViewController.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/04.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then
import RxSwift


class TimerViewController: BaseViewController {
    
    var timer: [timerList] = []
    var publicCount = 1
    var publicNowCount = 0
    var isCompliting = false
    
    
    private let navigationBarView = UIView()
    
    private let navigationTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.semiBold.font(size: 18)
        $0.text = "타이머"
    }
    
    private let backButton = UIButton().then {
        $0.setImage(UNITHONTeam6IOSAsset.Assets.iconArrowBack.image, for: .normal)
    }
    
    private let detailView = UIView().then {
        $0.backgroundColor = .color372F44
        $0.layer.cornerRadius = 20
    }
    
    private let detailImageView = UIImageView().then {
        $0.image = UNITHONTeam6IOSAsset.Assets.iconINFORM.image
    }
    private let detailTitleLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.numberOfLines = 0
        $0.font = PretendardFont.medium.font(size: 13)
    }
    
    private let timerBackView = UIView()
    
    private let clockImageView = UIImageView().then {
        $0.image = UNITHONTeam6IOSAsset.Assets.iconTimer.image
        $0.contentMode = .scaleAspectFill
    }
    private let timerLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let nextButton = UIButton().then {
        $0.setImage(UNITHONTeam6IOSAsset.Assets.iconSkip.image, for: .normal)
        $0.backgroundColor = .categoryPurpleLight
        $0.layer.cornerRadius = 30

    }
    
    private let skipLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "다음"
        $0.font = PretendardFont.semiBold.font(size: 15)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isCompliting = true
    }
    
    override func configureUI() {
        view.backgroundColor = .backgroudNavy
        view.addSubviews([navigationBarView, detailView, nextButton, timerBackView, skipLabel])
        navigationBarView.addSubviews([backButton, navigationTitleLabel])
        detailView.addSubviews([detailImageView, detailTitleLabel])
        timerBackView.addSubviews([clockImageView, timerLabel])
        print("configureUI😎😎")
        timeRemte(nowCount: 0)
        nextButton.addTarget(self, action: #selector(nextButtonClicked(_:)), for: .touchUpInside)

    }
    
    override func bind() {
        backButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func timeRemte(nowCount: Int) {
        let totalCount = timer.count
        print(timer)
        print(timer.count)

        var nowNumber = nowCount
        if nowNumber >= totalCount {
            self.makeOKAlert(title: "요리가 완료되었습니다!", message: "맛있게 드세요!", okAction: {_ in
                print("완료")
                self.navigationController?.popViewController(animated: true)
            }, completion: nil)
            return

        }
        timerToString(timer[nowNumber].sec).bind { count in
            self.publicCount = count
            if self.isCompliting {
                nowNumber = totalCount + 1
                return
            }
            if nowNumber > totalCount {
                print("완료")
                self.isCompliting = true
            } else {
                if self.timer[nowNumber].sec == 0 {
                    self.timerLabel.text = "정해진 조리시간이 없어요\n조리가 끝났으면 넘어가주세요!"
                    self.timerLabel.setLineSpacing(lineSpacing: 8)
                    self.timerLabel.textAlignment = .center
                    self.timerLabel.sizeToFit()
                    self.timerLabel.font = PretendardFont.semiBold.font(size: 18)
                    self.timerLabel.numberOfLines = 2
                    self.clockImageView.image = UNITHONTeam6IOSAsset.Assets.iconMegaphone.image
                } else {
                    let str = String(format: "00:%02d:%02d", (count % 3600) / 60, (count % 3600) % 60)
                    self.timerLabel.text = str
                    self.clockImageView.image = UNITHONTeam6IOSAsset.Assets.iconTimer.image
                    self.timerLabel.font = PretendardFont.semiBold.font(size: 48)

                }
                self.detailTitleLabel.text = "\(self.timer[nowNumber].text)\n (\(nowNumber + 1)/\(totalCount))"
                print("mow: \(count), nowNum: \(nowNumber)")
            }
        }.disposed(by: disposeBag)
    }
    
    
    override func setupConstraints() {
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        detailView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(0).inset(25)
        }
        
        detailImageView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(17)
            $0.width.height.equalTo(30)
        }
        
        detailTitleLabel.snp.makeConstraints {
            $0.left.equalTo(detailImageView.snp.right).offset(6)
            $0.right.equalToSuperview().inset(30)
            $0.top.bottom.equalTo(0).inset(24)
        }
        
        
        timerBackView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view).offset(10)
            $0.height.equalTo(222)
            $0.width.equalTo(245)
        }
        
        clockImageView.snp.makeConstraints {
          //  $0.leading.trailing.equalTo(0).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(140)
            $0.top.equalTo(0)
        }
        
        timerLabel.snp.makeConstraints {
           // $0.height.equalTo(48)
            $0.top.equalTo(clockImageView.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(0)
         //   $0.bottom.equalTo(0)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(timerBackView.snp.bottom).offset(68)
            $0.width.height.equalTo(60)
        }
        
        skipLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(nextButton.snp.bottom).offset(15)
        }
    }
    @objc func nextButtonClicked(_ button: UIButton) {
        print("befor")
        print("--publicCount: \(publicCount), publicNowCount: \(publicNowCount)--")
        print(publicCount)
        print(timer.count)
        if publicNowCount < timer.count {
            print("after")
            print("--publicCount: \(publicCount), publicNowCount: \(publicNowCount)--")
            print(timer.count)
            if publicCount == 0 {
                publicNowCount = publicNowCount + 1
                self.timeRemte(nowCount: publicNowCount)
            } else {
                self.showToast(message: "타이머가 종료되기 전까지는 넘어갈 수 없습니다", font: UNITHONTeam6IOSFontFamily.Pretendard.medium.font(size: 13))
            }

        }
        
    }
}

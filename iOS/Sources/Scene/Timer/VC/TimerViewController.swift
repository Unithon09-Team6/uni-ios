//
//  TimerViewController.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/04.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

class TimerViewController: BaseViewController {
    
    var timer: [timerList] = []
    
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
        $0.image = UNITHONTeam6IOSAsset.Assets.iconInform.image
    }
    private let detailTitleLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.numberOfLines = 0
        $0.font = PretendardFont.medium.font(size: 13)
    }
    
    private let timerBackView = UIView()

    private let clockImageView = UIImageView().then {
        $0.image = UNITHONTeam6IOSAsset.Assets.iconTimer.image
    }
    private let timerLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "00:00:00"
        $0.font = PretendardFont.semiBold.font(size: 48)
    }
    
    private let nextButton = UIButton().then {
        $0.setImage(UNITHONTeam6IOSAsset.Assets.iconSkip.image, for: .normal)
        $0.backgroundColor = .categoryPurpleLight
        $0.layer.cornerRadius = 30
    }
    
    private let skipLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "스킵하기"
        $0.font = PretendardFont.semiBold.font(size: 15)
    }

    
    override func configureUI() {
        
        detailTitleLabel.text = "배추김치와 스팸은 잘게 썰고 대파는 굵게 다집니다."
        
        view.backgroundColor = .backgroudNavy
        view.addSubviews([navigationBarView, detailView, nextButton, timerBackView, skipLabel])
        navigationBarView.addSubviews([backButton, navigationTitleLabel])
        detailView.addSubviews([detailImageView, detailTitleLabel])
        timerBackView.addSubviews([clockImageView, timerLabel])
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
            $0.centerY.equalTo(detailImageView)
            $0.left.equalTo(detailImageView.snp.right).offset(6)
            $0.right.equalTo(-10)
            $0.top.bottom.equalTo(0).inset(24)
        }

        
        timerBackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view)
            $0.height.equalTo(217)
            $0.width.equalTo(214)
        }
        
        clockImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(0).inset(30)
            $0.top.equalTo(0)
        }
        
        timerLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalTo(0)
            $0.bottom.equalTo(0)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(timerBackView.snp.bottom).offset(60)
            $0.width.height.equalTo(60)
        }
        
        skipLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(nextButton.snp.bottom).offset(15)
        }
    }
    
}

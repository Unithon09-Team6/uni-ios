//
//  TimerViewController.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/04.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

class TimerViewController: BaseViewController {
    
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
        $0.image = UNITHONTeam6IOSAsset.Assets.iconFood.image
    }
    private let detailTitleLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.font = PretendardFont.medium.font(size: 14)
    }

    private let clockImageView = UIImageView().then {
        $0.image = UNITHONTeam6IOSAsset.Assets.iconClock.image
    }
    
}

//
//  MainVC.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class MainVC: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.text = "오늘도\n실패하지않는 레시피"
        $0.numberOfLines = 2
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.bold.font(size: 26)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }
    
    private func setLayout() {
        
    }
}

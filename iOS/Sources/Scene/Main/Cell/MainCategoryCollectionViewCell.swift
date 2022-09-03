//
//  MainCategoryCollectionViewCell.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class MainCategoryCollectionViewCell: UICollectionViewCell {
    
    private let bgView = UIView().then {
        $0.cornerRadius = 20
        $0.backgroundColor = .purple
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "description"
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.semiBold.font(size: 13)
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "한식"
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.bold.font(size: 22)
    }
    
    private let foodImageView = UIImageView().then {
        $0.backgroundColor = .white
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    func setData(mainCategory: MainCategory) {
        bgView.backgroundColor = mainCategory.color
    }
    
    private func setLayout() {
        addSubviews([bgView])
        bgView.addSubviews([descriptionLabel, titleLabel, foodImageView])
        
        bgView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(18)
        }
        
        foodImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(22)
            $0.width.height.equalTo(65)
        }
    }
}

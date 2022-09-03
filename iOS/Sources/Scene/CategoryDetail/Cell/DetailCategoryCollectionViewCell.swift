//
//  DetailCategoryCollectionViewCell.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class DetailCategoryCollectionViewCell: UICollectionViewCell {
    
    private let bgView = UIView().then {
        $0.backgroundColor = .searchBarBackgroudNavy
        $0.cornerRadius = 15
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = .gray9A97A0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        self.addSubviews([bgView])
        bgView.addSubviews([titleLabel])
        
        bgView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func setData(category: String, isSelected: Bool) {
        titleLabel.text = category
        bgView.backgroundColor = isSelected ? .purple583680 : .searchBarBackgroudNavy
    }
}

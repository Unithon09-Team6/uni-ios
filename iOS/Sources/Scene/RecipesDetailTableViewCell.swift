//
//  RecipesDetailTableViewCell.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

class RecipesDetailTableViewCell: BaseTableViewCell {
    
    let backView = UIView().then {
        $0.backgroundColor = .color372F44
        $0.layer.cornerRadius = 20
    }
    
    let iconImageView = UIImageView().then {
        $0.backgroundColor = .categoryPinkLight
    }
    let contentLabel = UILabel().then {
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = PretendardFont.medium.font(size: 13)
    }
    let timerBackView = UIView().then {
        $0.backgroundColor = .color212121
        $0.layer.cornerRadius = 13
    }
    let timerLabel = UILabel().then {
        $0.font = PretendardFont.medium.font(size: 13)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    override func configureUI() {
        contentLabel.text = "여기는 할 일이 들어갑니다"
        timerLabel.text = "2:00"
        contentView.backgroundColor = .backgroudNavy
        contentView.addSubview(backView)
        backView.addSubviews([iconImageView, contentLabel, timerBackView])
        timerBackView.addSubview(timerLabel)
    }
    override func setupConstraints() {
        backView.snp.makeConstraints {
            $0.top.bottom.equalTo(0).inset(10)
            $0.leading.trailing.equalTo(0).inset(25)
        }
        iconImageView.snp.makeConstraints {
            $0.top.left.equalTo(15)
            $0.width.height.equalTo(30)
        }
        contentLabel.snp.makeConstraints {
            $0.right.equalTo(-15)
            $0.top.equalTo(22)
            $0.left.equalTo(iconImageView.snp.right).offset(8)
        }
        timerBackView.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
            $0.right.equalTo(-18)
            $0.bottom.equalTo(-15)
            $0.width.equalTo(72)
        }
        timerLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

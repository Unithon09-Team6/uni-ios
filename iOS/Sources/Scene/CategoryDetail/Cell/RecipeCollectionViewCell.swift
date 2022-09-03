//
//  RecipeCollectionViewCell.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class RecipeCollectionViewCell: UICollectionViewCell {
    
    typealias PretendardFont = UNITHONTeam6IOSFontFamily.Pretendard
    
    private let bgView = UIView().then {
        $0.backgroundColor = .color372F44
        $0.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let recipeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = .colorE4E4E4
        $0.font = PretendardFont.medium.font(size: 12)
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = PretendardFont.bold.font(size: 15)
    }
    
    private let timerImageView = UIImageView().then {
        $0.image = UNITHONTeam6IOSAsset.Assets.imageClock.image
    }
    
    private let totalTimerLabel = UILabel().then {
        $0.textColor = .white
        $0.font = PretendardFont.semiBold.font(size: 12)
    }
    
    private let timerStackView = UIStackView().then {
        $0.distribution = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(recipe: Recipes) {
        titleLabel.text = recipe.productName
        descriptionLabel.text = recipe.title
        recipeImageView.image(url: recipe.picUrl)
        totalTimerLabel.text = "\(recipe.totalCount)분"
    }
    
    private func setLayout() {
        
        self.addSubviews([bgView])
        bgView.addSubviews([recipeImageView, descriptionLabel, titleLabel, timerStackView])
        
        bgView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        recipeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(132)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(recipeImageView.snp.bottom).offset(14)
            $0.height.equalTo(14)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(18)
        }
        
        timerStackView.addArrangedSubview(timerImageView)
        timerStackView.addArrangedSubview(totalTimerLabel)
        timerImageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
            $0.leading.equalToSuperview()
        }
        
        timerStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
}

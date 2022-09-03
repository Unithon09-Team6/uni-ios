//
//  MainCategory.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

struct MainCategory {
    
    let description: String
    let name: String
    let image: UIImage
    let color: UIColor
    let number: Int
    
    static let mainCategories = [MainCategory(description: "한국인이라면 역시", name: "한식", image: UNITHONTeam6IOSAsset.Assets.imageKorea.image, color: .categoryPurpleLight, number: 0),
                                  MainCategory(description: "집에서 쉽게 해먹자!", name: "중식", image: UNITHONTeam6IOSAsset.Assets.imageChina.image, color: .categoryPinkLight, number: 1),
                                  MainCategory(description: "난 지금 양식이 땡긴다", name: "양식", image: UNITHONTeam6IOSAsset.Assets.imageWesternStyle.image, color: .categoryYellowLight, number: 2),
                                  MainCategory(description: "내 손안의 이자카야", name: "일식", image: UNITHONTeam6IOSAsset.Assets.imageJapan.image, color: .categoryBlueLight, number: 3)]
}

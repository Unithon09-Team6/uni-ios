//
//  Recipes.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import Foundation

struct Recipes: Codable {
    let _id: String
    let productName: String?
    let title: String
    let category: Int
    let subCategory: String
    let picUrl: String
    let detail: String
    let totalCount: Int
    let timer: [timerList]
    let __v: Int
}

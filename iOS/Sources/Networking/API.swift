//
//  API.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import Foundation
import Moya

enum API {
    
    case getRecipes(_ id: String)
    
    case searchRecipes(_ target: String, _ paging: String)
    
    case searchCategoryRecipes(_ category: String, _ paging: String)
    
    case getSubCategoryList(_ category: String)
    case getSubCategory(_ category: String)
}

extension API: Moya.TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var sampleData: Data { Data() }
    var task: Task { return getTask() }
    var headers: [String : String]? { return getHeader() }
}

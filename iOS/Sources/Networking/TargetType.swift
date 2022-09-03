//
//  TargetType.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import Foundation

import Foundation
import Moya
import Then

extension API {
    
    func getBaseURL() -> URL {
        return URL(string: UNIURL.baseURL)!
    }
    
    func getPath() -> String {
        switch self {
        case .getRecipes:
            return "/recipes"
        case .searchRecipes:
            return "/recipes/search"
        case .searchCategoryRecipes:
            return "/recipes/search/category"
        case .getSubCategoryList:
            return "/subs"
        case .getSubCategory:
            return "/subs/id"
        }
    }
    
    func getMethod() -> Moya.Method {
        return .get
    }
    
    func getTask() -> Task {
        switch self {
        case .getRecipes(let id):
            let params: [String: Any] = [
                "id": id,
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .searchRecipes(let target, let paging):
            let params: [String: Any] = [
                "target": target,
                "paging": paging,
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .searchCategoryRecipes(let category, let paging):
            let params: [String: Any] = [
                "category": category,
                "paging": paging,
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getSubCategoryList(let category):
            let params: [String: Any] = [
                "category": category,
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getSubCategory(let category):
            let params: [String: Any] = [
                "category": category,
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        }
    }
    
    func getHeader() -> [String : String] {
        return ["Accept": "application/json"]
    }
}

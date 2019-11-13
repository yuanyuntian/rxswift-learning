//
//  GitHubAPI.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/13.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation
import Moya


//初始化github请求的provider
let GitHubProvider = MoyaProvider<GitHubAPI>()

//请求分类
public enum GitHubAPI {
    case repositories(String)
}

//请求配置
extension GitHubAPI:TargetType {
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    
    public var baseURL: URL {
        return URL(string:"https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        print("发起请求")
        switch self {
        case .repositories(let query):
            var params: [String:Any] = [:]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    //是否执行Alamofire验证
    public var vilidate: Bool {
        return false
    }
    
    
}

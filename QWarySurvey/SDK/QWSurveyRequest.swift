//
//  QWSurveyRequest.swift
//  QWarySurvey
//
//  Created by fahid on 30/06/2022.
//

import Foundation

@objc public class QWSurveyRequest: NSObject {
    
    // MARK: Properties
    var scheme: String!
    var host: String!
    var path: String!
    var params: [String:String]!
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = self.scheme
        urlComponent.host = self.host
        urlComponent.path = self.path
        urlComponent.queryItems = params.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return urlComponent.url
    }

    // MARK: Initialize
    @objc public convenience init(scheme: String, host: String, path: String, params: [String:String]) {
        self.init()
        self.scheme = scheme
        self.host = host
        self.path = path
        self.params = params
    }

    // MARK: Initialize
    @objc public convenience init(jsonString: String) {
        self.init()
        if let json = jsonString.toJSON() as? [String:Any] {
            if let domain = json["domain"] as? String {
                let components = domain.components(separatedBy: "://")
                if let scheme = components.first {
                    self.scheme = scheme
                }
                if let host = components.last {
                    self.host = host
                }
            }
            if let token = json["token"] as? String {
                self.path = token
            }
            if let paramsValue = json["params"] as? [[String:String]], let params = paramsValue.first {
                self.params = params
            }
        }
        
        print("scheme: \(self.scheme)")
        print("host: \(self.host)")
        print("params: \(self.params)")
    }
}

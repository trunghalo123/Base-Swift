//
//  ApiBase.swift
//  Base
//
//  Created by Be More on 1/25/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiBase {
    private static var timeOut: TimeInterval = 10
    private static var baseUrl = ""
    
    static let share: ApiBase = ApiBase()
    
    /// configure url and time out interval
    static func configure(apiConfigue: ApiConfigure) {
        self.baseUrl = apiConfigue.baseUrl
        self.timeOut = apiConfigue.timeOut
    }
    
    private func baseRequest(baseUrl: String,
                             urlString: String? = nil,
                             httpMethod: HTTPMethod,
                             apiHeader: [String: String]?,
                             param: [String: Any]?,
                             body: [String: Any]?,
                             completion: DataCompletion?) {
        
        // create URL
        var url: URLComponents
        if let urlString = urlString {
            url = URLComponents(string: "\(baseUrl)/\(urlString)")!
        } else {
            url = URLComponents(string: baseUrl)!
        }
        
        // item query
        var queryItems = [URLQueryItem]()
        if let param = param {
            for paramItems in param {
                let value = String(describing: paramItems.value)
                queryItems.append(URLQueryItem(name: paramItems.key, value: value))
            }
        }
        
        url.queryItems = queryItems
        
        // create request and set header
        
        let request = NSMutableURLRequest(url: url.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: ApiBase.timeOut)
        request.httpMethod = httpMethod.rawValue
    
        do {
            if let body = body {
                let bodyData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = bodyData
            }
        } catch {
            dLogError("JSONSerialization.data exception \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            let httpUrlResponse = response as? HTTPURLResponse
            let statusCode = httpUrlResponse?.statusCode
            dLogDebug("BASE API STATUS: \(String(describing: httpUrlResponse?.url?.absoluteString)) ---> \(String(describing: statusCode))")
            if error != nil {
                completion?(nil, nil)
            } else {
                completion?(statusCode, data)
            }
        }
        task.resume()
    }
    
    // Create request, call and response (code, JSON-SwiftyJSON)
    func request(baseUrl: String = baseUrl,
                 urlString: String? = nil,
                 httpMethod: HTTPMethod,
                 apiHeader: [String: String]?,
                 param: [String: Any]?,
                 body: [String: Any]?,
                 completion: JSONCompletion?) {
        baseRequest(baseUrl: baseUrl,
                    urlString: urlString,
                    httpMethod: httpMethod,
                    apiHeader: apiHeader,
                    param: param,
                    body: body) { (code, data) in
                        if let data = data {
                            let json = JSON(data)
                            completion?(code, json)
                            dLogDebug("API STATUS: \(baseUrl) ---> CODE = \(code ?? 0) RESPONSE = \(json)")
                            completion?(code, json)
                        } else {
                            dLogDebug("API STATUS: \(baseUrl) ---> CODE = \(code ?? 0) --- RESPONSE = nil")
                            completion?(code, nil)
                        }
        }
        
    }
    
    // Create request, call and response (status, code, JSON-SwiftyJSON)
    func request(urlString: String? = nil,
                 httpMethod: HTTPMethod,
                 header: [String: String]? = nil,
                 param: [String: Any]? = nil,
                 body: [String: Any]? = nil,
                 completion: Completion?) {
        request(urlString: urlString, httpMethod: httpMethod, apiHeader: header, param: param, body: body) { (code, json) in
            if let code = code, let json = json {
                if 200 ... 299 ~= code {
                    completion?(true, code, json)
                } else {
                    completion?(false, code, json)
                }
            } else {
                completion?(false, nil, nil)
            }
        }
    }
       
       // create request for web view
       func request(baseUrl: String = baseUrl,
                    urlString: String? = nil,
                    httpMethod: HTTPMethod,
                    header: [String: String]? = nil,
                    param: [String: Any]? = nil,
                    body: [String: Any]? = nil,
                    completion: HTMLStringCompletion?) {
        
        baseRequest(baseUrl: baseUrl, urlString: urlString, httpMethod: httpMethod, apiHeader: header, param: param, body: body) { (code, data) in
            if let data = data {
                guard  let content = String(data: data, encoding: .utf8) else {
                    completion?(nil)
                    return
                }
                completion?(content)
            } else {
                completion?(nil)
            }
        }
    
       }
}


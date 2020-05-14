//
//  ApiDefine.swift
//  Base
//
//  Created by Be More on 1/25/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import SwiftyJSON

// completion closure
typealias DataCompletion =  (_ code: Int?, _ data: Data?) -> ()
typealias JSONCompletion = (_ code: Int?, _ json: JSON?) -> ()
typealias Completion = (_ status: Bool?, _ code: Int?, _ json: JSON?) -> ()
typealias HTMLStringCompletion = (_ htmlString: String?) -> ()

// HTTP method
enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

// buider configure
class ApiConfigure {
    var timeOut: TimeInterval = 10
    var baseUrl: String = ""
    
    func baseUrl(url: String) -> ApiConfigure {
        self.baseUrl = url
        return self
    }
    
    func timeOut(time: TimeInterval) -> ApiConfigure {
        self.timeOut = time
        return self
    }
}

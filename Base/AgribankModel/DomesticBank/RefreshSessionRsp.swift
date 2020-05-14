//
//  RefreshSessionRsp.swift
//  Base
//
//  Created by Be More on 2/13/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

//Request URL: http://10.14.104.6:8200/session/refreshSession
//Request Method: POST


// MARK: - Repuest header
//Accept: application/json, text/plain, */*
//Accept-Encoding: gzip, deflate
//Accept-Language: vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7
//Authorization: Base b8f3be20929271801a1ae7b22221dd6b
//Connection: keep-alive
//Content-Length: 103
//Content-Type: application/json
//Cookie: http%3A%2F%2F10.14.104.6%3A8200LANGUAGE=en; http%3A%2F%2F10.14.104.6%3A8200SESSION=%7B%22SessionKey%22%3A%22b8f3be20929271801a1ae7b22221dd6b%22%2C%22SessionID%22%3A37913%2C%22UserID%22%3A924%2C%22Username%22%3A%22TrangNTT53%22%2C%22BranchId%22%3A%221420%22%2C%22DisplayName%22%3Anull%2C%22CreateDate%22%3A%222020-02-13T15%3A37%3A56%22%2C%22LastAccess%22%3A%222020-02-13T15%3A38%3A09%22%2C%22ClientIP%22%3A%2210.15.180.128%22%2C%22DNSName%22%3A%2210.15.180.128%22%2C%22SessionStatus%22%3A%22A%22%2C%22TerminatedUsername%22%3Anull%2C%22Description%22%3Anull%2C%22WorkingDate%22%3A%222020-03-12T00%3A00%3A00%22%2C%22BatchDate%22%3A%222020-03-12T00%3A00%3A00%22%2C%22SystemDate%22%3A%222020-02-13T16%3A07%3A27%22%2C%22SettleDate%22%3A%220001-01-01T00%3A00%3A00%22%2C%22SystemStatus%22%3Anull%2C%22AllowDevelop%22%3A%22A%22%2C%22AllowViewAllData%22%3A%22Y%22%2C%22LanguageID%22%3A%22VN%22%2C%22RequireResetPassword%22%3Anull%2C%22ExtraData%22%3A%7B%22MEMBER_ID%22%3A%22%22%2C%22PASSWORD%22%3A%22e10adc3949ba59abbe56e057f20f883e%22%2C%22MARKET_INFO%22%3A%2212%2F03%2F2020%22%2C%22ISUSECA%22%3A%22N%22%2C%22USERCANAME%22%3A%22%22%7D%7D
//Host: 10.14.104.6:8200
//Origin: http://10.14.104.6:8200
//Referer: http://10.14.104.6:8200/
//User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36


// MARK: - Request
//{
//  "values": [],
//  "conditions": [],
//  "data": {},
//  "sessionId": "b8f3be20929271801a1ae7b22221dd6b"
//}

// MARK: - When use
// when user click in domestic bank function


// MARK: - Response
import Foundation
import SwiftyJSON

class RefreshSessionRsp {

    var status: String
    var result: RefreshSessionResult?

    init(_ json: JSON) {
        status = json["status"].stringValue
        result = RefreshSessionResult(json["result"])
    }

}

class RefreshSessionResult {
    var sessionKey: String
    var sessionID: Int
    var userID: Int
    var username: String
    var branchId: String
    var displayName: Any
    var createDate: String
    var lastAccess: String
    var clientIP: String
    var dNSName: String
    var sessionStatus: String
    var terminatedUsername: Any
    var description: Any
    var workingDate: String
    var batchDate: String
    var systemDate: String
    var settleDate: String
    var systemStatus: Any
    var allowDevelop: String
    var allowViewAllData: String
    var languageID: String
    var requireResetPassword: Any
    var extraData: ExtraData?

    init(_ json: JSON) {
        sessionKey = json["SessionKey"].stringValue
        sessionID = json["SessionID"].intValue
        userID = json["UserID"].intValue
        username = json["Username"].stringValue
        branchId = json["BranchId"].stringValue
        displayName = json["DisplayName"]
        createDate = json["CreateDate"].stringValue
        lastAccess = json["LastAccess"].stringValue
        clientIP = json["ClientIP"].stringValue
        dNSName = json["DNSName"].stringValue
        sessionStatus = json["SessionStatus"].stringValue
        terminatedUsername = json["TerminatedUsername"]
        description = json["Description"]
        workingDate = json["WorkingDate"].stringValue
        batchDate = json["BatchDate"].stringValue
        systemDate = json["SystemDate"].stringValue
        settleDate = json["SettleDate"].stringValue
        systemStatus = json["SystemStatus"]
        allowDevelop = json["AllowDevelop"].stringValue
        allowViewAllData = json["AllowViewAllData"].stringValue
        languageID = json["LanguageID"].stringValue
        requireResetPassword = json["RequireResetPassword"]
        extraData = ExtraData(json["ExtraData"])
    }

}

class ExtraData {
    var MEMBERID: String
    var PASSWORD: String
    var MARKETINFO: String
    var ISUSECA: String
    var USERCANAME: String

    init(_ json: JSON) {
        MEMBERID = json["MEMBER_ID"].stringValue
        PASSWORD = json["PASSWORD"].stringValue
        MARKETINFO = json["MARKET_INFO"].stringValue
        ISUSECA = json["ISUSECA"].stringValue
        USERCANAME = json["USERCANAME"].stringValue
    }
}

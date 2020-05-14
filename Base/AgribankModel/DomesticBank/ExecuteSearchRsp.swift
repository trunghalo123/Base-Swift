//
//  ExecuteSearchRsp.swift
//  Base
//
//  Created by Be More on 2/13/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

//Request URL: http://10.14.104.6:8200/search/executeSearch
//Request Method: POST


// MARK: - request header

//Accept: application/json, text/plain, */*
//Accept-Encoding: gzip, deflate
//Accept-Language: vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7
//Authorization: Base b8f3be20929271801a1ae7b22221dd6b
//Connection: keep-alive
//Content-Length: 197
//Content-Type: application/json
//Cookie: http%3A%2F%2F10.14.104.6%3A8200LANGUAGE=en; http%3A%2F%2F10.14.104.6%3A8200SESSION=%7B%22SessionKey%22%3A%22b8f3be20929271801a1ae7b22221dd6b%22%2C%22SessionID%22%3A37913%2C%22UserID%22%3A924%2C%22Username%22%3A%22TrangNTT53%22%2C%22BranchId%22%3A%221420%22%2C%22DisplayName%22%3Anull%2C%22CreateDate%22%3A%222020-02-13T15%3A37%3A56%22%2C%22LastAccess%22%3A%222020-02-13T15%3A38%3A02%22%2C%22ClientIP%22%3A%2210.15.180.128%22%2C%22DNSName%22%3A%2210.15.180.128%22%2C%22SessionStatus%22%3A%22A%22%2C%22TerminatedUsername%22%3Anull%2C%22Description%22%3Anull%2C%22WorkingDate%22%3A%222020-03-12T00%3A00%3A00%22%2C%22BatchDate%22%3A%222020-03-12T00%3A00%3A00%22%2C%22SystemDate%22%3A%222020-02-13T15%3A38%3A09%22%2C%22SettleDate%22%3A%220001-01-01T00%3A00%3A00%22%2C%22SystemStatus%22%3Anull%2C%22AllowDevelop%22%3A%22A%22%2C%22AllowViewAllData%22%3A%22Y%22%2C%22LanguageID%22%3A%22VN%22%2C%22RequireResetPassword%22%3Anull%2C%22ExtraData%22%3A%7B%22MEMBER_ID%22%3A%22%22%2C%22PASSWORD%22%3A%22e10adc3949ba59abbe56e057f20f883e%22%2C%22MARKET_INFO%22%3A%2212%2F03%2F2020%22%2C%22ISUSECA%22%3A%22N%22%2C%22USERCANAME%22%3A%22%22%7D%7D
//Host: 10.14.104.6:8200
//Origin: http://10.14.104.6:8200
//Referer: http://10.14.104.6:8200/
//User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36


// MARK: - request
//{
//  "values": [],
//  "conditions": [],
//  "data": {
//    "pageSize": 100
//  },
//  "moduleInfo": {
//    "ModuleID": "03074",
//    "SubModule": "MMN"
//  },
//  "sessionId": "b8f3be20929271801a1ae7b22221dd6b"
//}


// MARK: - when use
// When user enter domestic bank function and hit the search button


// MARK: - response
import Foundation
import Foundation
import SwiftyJSON

class ExecuteSearchRsp {

    var status: String
    var result: ExecuteSearchResult?

    init(_ json: JSON) {
        status = json["status"].stringValue
        result = ExecuteSearchResult(json["result"])
    }
}

class ExecuteSearchResult {

    var searchResultKey: String
    var searchTime: String
    var totalRows: Int
    var executeSearchData: [ExecuteSearchData]?

    init(_ json: JSON) {
        searchResultKey = json["searchResultKey"].stringValue
        searchTime = json["searchTime"].stringValue
        totalRows = json["totalRows"].intValue
        executeSearchData = json["data"].arrayValue.map { ExecuteSearchData($0) }
    }
}


class ExecuteSearchData {

    var AUTOID: Int
    var ID: Any
    var TENANTCODE: String
    var CODE: String
    var NAME: String
    var ONLCONN: String
    var ONLTRANSFER: String
    var BILCONN: String
    var BILTRANSFER: String
    var IBPSCONN: String
    var DELETED: String
    var ISACTIVE: String
    var REMARK: Any
    var REASON: Any
    var CREATEDBY: String
    var CREATEDDATE: String
    var MODIFIEDBY: String
    var MODIFIEDDATE: String
    var APPROVEDBY: Any
    var APPROVEDDATE: Any
    var BANKNAME: String

    init(_ json: JSON) {
        AUTOID = json["AUTO_ID"].intValue
        ID = json["ID"]
        TENANTCODE = json["TENANT_CODE"].stringValue
        CODE = json["CODE"].stringValue
        NAME = json["NAME"].stringValue
        ONLCONN = json["ONL_CONN"].stringValue
        ONLTRANSFER = json["ONL_TRANSFER"].stringValue
        BILCONN = json["BIL_CONN"].stringValue
        BILTRANSFER = json["BIL_TRANSFER"].stringValue
        IBPSCONN = json["IBPS_CONN"].stringValue
        DELETED = json["DELETED"].stringValue
        ISACTIVE = json["IS_ACTIVE"].stringValue
        REMARK = json["REMARK"]
        REASON = json["REASON"]
        CREATEDBY = json["CREATED_BY"].stringValue
        CREATEDDATE = json["CREATED_DATE"].stringValue
        MODIFIEDBY = json["MODIFIED_BY"].stringValue
        MODIFIEDDATE = json["MODIFIED_DATE"].stringValue
        APPROVEDBY = json["APPROVED_BY"]
        APPROVEDDATE = json["APPROVED_DATE"]
        BANKNAME = json["BANK_NAME"].stringValue
    }

}

//
//  InternationalBankSearchRsp.swift
//  Base
//
//  Created by Be More on 2/13/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

//Request URL: http://10.14.104.6:8200/search/executeSearch
//Request Method: POST


// MARK: - Request header
//Accept: application/json, text/plain, */*
//Accept-Encoding: gzip, deflate
//Accept-Language: vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7
//Authorization: Base 8389fa4c9d83650793886cba4edb30
//Connection: keep-alive
//Content-Length: 195
//Content-Type: application/json
//Cookie: http%3A%2F%2F10.14.104.6%3A8200LANGUAGE=en; http%3A%2F%2F10.14.104.6%3A8200SESSION=%7B%22SessionKey%22%3A%228389fa4c9d83650793886cba4edb30%22%2C%22SessionID%22%3A37924%2C%22UserID%22%3A924%2C%22Username%22%3A%22TrangNTT53%22%2C%22BranchId%22%3A%221420%22%2C%22DisplayName%22%3Anull%2C%22CreateDate%22%3A%222020-02-13T17%3A03%3A17%22%2C%22LastAccess%22%3A%222020-02-13T17%3A08%3A22%22%2C%22ClientIP%22%3A%2210.15.180.128%22%2C%22DNSName%22%3A%2210.15.180.128%22%2C%22SessionStatus%22%3A%22A%22%2C%22TerminatedUsername%22%3Anull%2C%22Description%22%3Anull%2C%22WorkingDate%22%3A%222020-03-12T00%3A00%3A00%22%2C%22BatchDate%22%3A%222020-03-12T00%3A00%3A00%22%2C%22SystemDate%22%3A%222020-02-13T17%3A09%3A05%22%2C%22SettleDate%22%3A%220001-01-01T00%3A00%3A00%22%2C%22SystemStatus%22%3Anull%2C%22AllowDevelop%22%3A%22A%22%2C%22AllowViewAllData%22%3A%22Y%22%2C%22LanguageID%22%3A%22VN%22%2C%22RequireResetPassword%22%3Anull%2C%22ExtraData%22%3A%7B%22MEMBER_ID%22%3A%22%22%2C%22PASSWORD%22%3A%22e10adc3949ba59abbe56e057f20f883e%22%2C%22MARKET_INFO%22%3A%2212%2F03%2F2020%22%2C%22ISUSECA%22%3A%22N%22%2C%22USERCANAME%22%3A%22%22%7D%7D
//Host: 10.14.104.6:8200
//Origin: http://10.14.104.6:8200
//Referer: http://10.14.104.6:8200/
//User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36


// MARK: - Request

//{
//  "values": [],
//  "conditions": [],
//  "data": {
//    "pageSize": 100
//  },
//  "moduleInfo": {
//    "ModuleID": "03073",
//    "SubModule": "MMN"
//  },
//  "sessionId": "8389fa4c9d83650793886cba4edb30"
//}


// MARK: - Reaponse
import Foundation
import SwiftyJSON

class InternationalBankSearchRsp {

    let status: String?
    let result: InternationalBankSearchResult?

    init(_ json: JSON) {
        status = json["status"].stringValue
        result = InternationalBankSearchResult(json["result"])
    }

}

class InternationalBankSearchResult {

    let searchResultKey: String?
    let searchTime: String?
    let totalRows: Int?
    let data: [InternationalBankSearchData]?

    init(_ json: JSON) {
        searchResultKey = json["searchResultKey"].stringValue
        searchTime = json["searchTime"].stringValue
        totalRows = json["totalRows"].intValue
        data = json["data"].arrayValue.map { InternationalBankSearchData($0) }
    }

}

class InternationalBankSearchData {
    let AUTOID: Int?
    let BICSWIFTCODE: String?
    let CHIPSUID: Any?
    let NAME: String?
    let ORGDIREC: String?
    let ORGCODE: Any?
    let CITY: Any?
    let COUNTRY: String?
    let REMARK: Any?
    let ISACTIVE: String?
    let CREATEDBY: String?
    let CREATEDDATE: String?
    let MODIFIEDBY: Any?
    let MODIFIEDDATE: Any?
    let DELETED: String?

    init(_ json: JSON) {
        AUTOID = json["AUTO_ID"].intValue
        BICSWIFTCODE = json["BICSWIFTCODE"].stringValue
        CHIPSUID = json["CHIPS_UID"]
        NAME = json["NAME"].stringValue
        ORGDIREC = json["ORG_DIREC"].stringValue
        ORGCODE = json["ORG_CODE"]
        CITY = json["CITY"]
        COUNTRY = json["COUNTRY"].stringValue
        REMARK = json["REMARK"]
        ISACTIVE = json["IS_ACTIVE"].stringValue
        CREATEDBY = json["CREATED_BY"].stringValue
        CREATEDDATE = json["CREATED_DATE"].stringValue
        MODIFIEDBY = json["MODIFIED_BY"]
        MODIFIEDDATE = json["MODIFIED_DATE"]
        DELETED = json["DELETED"].stringValue
    }

}

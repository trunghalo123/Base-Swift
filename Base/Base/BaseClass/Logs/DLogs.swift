//
//  DLogs.swift
//  Base
//
//  Created by Be More on 1/29/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation

enum DLogs: String {
    case debug = "💜[DEBUG]"
    case info = "💚[INFO]"
    case warning = "💛[WARNING]"
    case error = "❤️[ERROR]"
}

/// In ra các thông tin. Chỉ thực hiện khi chạy debug
///
/// - Parameters:
///   - tag: Loại phân biệt
///   - logMessage: Nội dung
///   - functionName: function gọi log
///   - line: Dòng câu lệnh log được viết
///   - fileName: File chứa câu lệnh log
///   - column: Kí tự bắt đầu của câu lệnh log

fileprivate func dLog(tag: DLogs, _ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, colum: Int = #column) {
    #if RELEASE
    #else
    let tag = tag.rawValue
    let fileName = (fileName as NSString).lastPathComponent
    let logDate = Date().stringForLog()
    let logString = "\(logDate) \(tag) \(logMessage)\n\tAt: [\(fileName)] - [\(functionName)] - [Line \(line)]"
    Swift.print(logString)
    #endif
}

func dLogDebug(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, colum: Int = #column) {
    dLog(tag: .debug, logMessage, functionName: functionName, line: line, fileName: fileName, colum: colum)
}

func dLogInfo(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, colum: Int = #column) {
    dLog(tag: .info, logMessage, functionName: functionName, line: line, fileName: fileName, colum: colum)
}

func dLogWarning(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, colum: Int = #column) {
    dLog(tag: .warning, logMessage, functionName: functionName, line: line, fileName: fileName, colum: colum)
}

func dLogError(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, colum: Int = #column) {
    dLog(tag: .error, logMessage, functionName: functionName, line: line, fileName: fileName, colum: colum)
}

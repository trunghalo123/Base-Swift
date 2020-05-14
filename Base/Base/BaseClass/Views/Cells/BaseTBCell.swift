//
//  BaseTBCell.swift
//  Base
//
//  Created by Be More on 2/11/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import UIKit

class BaseTBCell: UITableViewCell {
    
    private static func nibName() -> String {
        return String(describing: self.self)
    }
    
    static func height() -> CGFloat {
        return 0
    }
    
    static func registerCellByNib(tableView: UITableView) {
        tableView.register(UINib(nibName: nibName(), bundle: nil), forCellReuseIdentifier: self.nibName())
        
    }
    
    static func registerCellByClass(tableView: UITableView) {
        tableView.register(self.self, forCellReuseIdentifier: self.nibName())
    }
    
    static func loadCell(tableView: UITableView) -> BaseTBCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: self.nibName())) as? BaseTBCell else {
                return BaseTBCell()
        }
        return cell
    }
    
    static func loadCell(tableView: UITableView, indexPath: IndexPath) -> BaseTBCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: self.nibName(), for: indexPath)) as? BaseTBCell else {
            return BaseTBCell()
        }
        return cell
    }
    
}

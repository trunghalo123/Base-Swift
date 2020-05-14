//
//  EmptyView.swift
//  Base
//
//  Created by Be More on 2/11/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import UIKit

class EmptyView: BaseCustomNibView {

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBInspectable var title: String {
        get {
            return self.labelTitle.text ?? ""
        } set {
            self.labelTitle.text = newValue
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hidden() {
        self.isHidden = true
    }
    
}

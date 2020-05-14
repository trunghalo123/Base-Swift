//
//  BaseCustomNibView.swift
//  Base
//
//  Created by Be More on 2/11/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import UIKit

class BaseCustomNibView: UIView {
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    private func nibName() -> String {
        return String(describing: type(of: self))
    }
    
    private func commomInit() {
        let nibName = self.nibName()
        let nib = UINib(nibName: nibName, bundle: nil) // normal nib view init.
        nib.instantiate(withOwner: self, options: nil) // init view.
        addSubview(self.contentView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
}

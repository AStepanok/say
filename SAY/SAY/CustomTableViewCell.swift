//
//  CustomTableViewCell.swift
//  SAY
//
//  Created by Антон Степанок on 15.03.2020.
//  Copyright © 2020 Антон Степанок. All rights reserved.
//

import UIKit

@IBDesignable class CustomLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 20
    @IBInspectable var bottomInset: CGFloat = 20
    @IBInspectable var leftInset: CGFloat = 20
    @IBInspectable var rightInset: CGFloat = 20
    

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}

class CustomTableViewCell: UITableViewCell {
    

    @IBOutlet weak var message: CustomLabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

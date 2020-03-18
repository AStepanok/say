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

protocol MessageShareDelegate: class {
     // you can add parameters if you want to pass. something to controller
    func shareButtonPressed(messageItem: MessageItem)
}

class CustomTableViewCell: UITableViewCell {
    
    public var messageItem: MessageItem?
    
    public weak var delegate: MessageShareDelegate?
    
    @IBOutlet weak var message: CustomLabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        delegate?.shareButtonPressed(messageItem: messageItem as! MessageItem)
    }
    
}

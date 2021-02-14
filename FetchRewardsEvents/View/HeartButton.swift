//
//  HeartButton.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/11/21.
//

import UIKit

@IBDesignable class HeartButton: UIButton {

    @IBInspectable var filled: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
@IBInspectable var strokeWidth: CGFloat = 2.0
@IBInspectable var strokeColor: UIColor? = UIColor.red

override func draw(_ rect: CGRect) {
    let bezierPath = UIBezierPath(heartIn: self.bounds)

    if self.strokeColor != nil {
        self.strokeColor!.setStroke()
    } else {
        self.tintColor.setStroke()
    }

    bezierPath.lineWidth = self.strokeWidth
    bezierPath.stroke()

    if self.filled {
        self.tintColor.setFill()
        bezierPath.fill()
    }
}
}

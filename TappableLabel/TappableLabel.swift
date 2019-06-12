//
//  TappableLabel.swift
//  TappableLabel
//
//  Created by Sudhanshu Sudhanshu on 12/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class TappableLabel: UILabel {

    private var clickableIndices: [Int]?
    private let layoutManager = NSLayoutManager()
    private let textContainer = NSTextContainer()
    private let textStorage = NSTextStorage()
    
    var tappableRanges: [NSRange]!
    var tapGesture: UITapGestureRecognizer!
    var tapCallback: ((Int)->())!
    
    func addAction(for attributedString: NSAttributedString, at tappableRanges: [NSRange]) {
        self.attributedText = attributedString
        self.isUserInteractionEnabled = true
        self.tappableRanges = tappableRanges
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapActionHandler))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapActionHandler(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        
        // Configure NSLayoutManager
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure NSTextContainer
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = 0
        textContainer.lineBreakMode = lineBreakMode
        
        let size = self.bounds.size
        textContainer.size = size
        
        // Tapped location
        let touchLocation = tapGestureRecognizer.location(in: self)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: ((size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x),
                                          y: ((size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y))
        
        let locationInTextContainer = CGPoint(x: touchLocation.x - textContainerOffset.x, y: touchLocation.y - textContainerOffset.y)
        
        let charIndex = layoutManager.characterIndex(for: locationInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        
        for index in 0..<tappableRanges.count {
            let range = tappableRanges[index]
            if NSLocationInRange(charIndex, range) {
                tapCallback(index)
            }
        }
    }
}

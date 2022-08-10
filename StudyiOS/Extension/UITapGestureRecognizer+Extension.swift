//
//  UITapGestureRecognizer+Extension.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/09.
//

import UIKit

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
            // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: CGSize.zero)
            let textStorage = NSTextStorage(attributedString: label.attributedText!)

            // Configure layoutManager and textStorage
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)

            // Configure textContainer
            textContainer.lineFragmentPadding = 0.0
            textContainer.lineBreakMode = label.lineBreakMode
            textContainer.maximumNumberOfLines = label.numberOfLines
            let labelSize = label.bounds.size
            textContainer.size = labelSize

            // Find the tapped character location and compare it to the specified range
            let locationOfTouchInLabel = self.location(in: label)
            let textBoundingBox = layoutManager.usedRect(for: textContainer) // text만 들어있는 textBoudning box
            
            let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y) // textContainer가 존재하는 곳의 좌표(CGPoint) 기준: label

            // touchpoint를 textContainer 좌표계를 기준으로 변경한다.
            let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        
            // y가 "보기" text가 위치한 지점보다 작으면 -> O
            // y가 "보기" text가 위치한 지점보다 같거나 크면 -> X가 "보기" text가 위치한 지점보다 작으면 -> O
        
            // touch point 지점에 존재하는 글자의 인덱스
            let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//        layoutManager.boundingR
//        let glyphCount = layoutManager.glyphRange(for: textContainer).length
//
//        print("label.textCount: \(label.text?.count)\nlabel.glypCount: \(glyphCount)")
//            print("indexOfCharacter: \(indexOfCharacter), targetRange: \(targetRange)\n")
            return NSLocationInRange(indexOfCharacter, targetRange)
        }
}

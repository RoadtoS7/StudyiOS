//
//  UITapGestureRecognizer+Extension.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/09.
//

import UIKit

// y가 "보기" text가 위치한 지점보다 작으면 -> O
// y가 "보기" text가 위치한 지점보다 같거나 크면 -> X가 "보기" text가 위치한 지점보다 작으면 -> O

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
        let textContainerView = UIView(frame: textBoundingBox)
        
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y) // textContainer가 존재하는 곳의 좌표(CGPoint) 기준: label
        
        
        let locationOfTouchInTextContainer = textContainerView.convert(locationOfTouchInLabel, from: label)
        
        let targetRect = layoutManager.boundingRect(forGlyphRange: targetRange, in: textContainer)
        print("targetRect.origin: \(targetRect.origin)\ntargetRect.size: \(targetRect.size)")
        print("touchPoinlocation: \(locationOfTouchInTextContainer)")
        
        return targetRect.contains(locationOfTouchInTextContainer)
        
        // touch point 지점에 존재하는 글자의 인덱스
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
    func didTapAttributedTextInLabel(textView: UITextView, inRange targetRange: NSRange) -> Bool {
        let text = textView.attributedText.string
        let seeMoreRange = (text as NSString).range(of: MultipleLinkTextViewController.seeMoreContent)
        let ranges = MultipleLinkTextViewController.seeMoreContent.map { char -> NSRange in
            let charSet = CharacterSet(charactersIn: String(char))
            return (text as NSString).rangeOfCharacter(from: charSet)
        }
        
        
        let layoutManager = textView.layoutManager
        let textContainer = textView.textContainer
    
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: textView)
        let textBoundingBox = layoutManager.usedRect(for: textContainer) // text만 들어있는 textBoudning box
        
        let textContainerView = UIView(frame: textBoundingBox)
        
        
        let locationOfTouchInTextContainer = textContainerView.convert(locationOfTouchInLabel, from: textView)
        
        
        let targetRect = layoutManager.boundingRect(forGlyphRange: targetRange, in: textContainer)
        let seeMoreRect = layoutManager.boundingRect(forGlyphRange: seeMoreRange, in: textContainer)
        let charRects = ranges.map { range in
            layoutManager.boundingRect(forGlyphRange: range, in: textContainer)
        }
        
        guard charRects.count >= 2 else { return false }
        
        if charRects[0].origin.y < charRects[1].origin.y {
            let firstTouchArea = touchAreaFromRect(charRects[0], until: textView, textContainerView: textContainerView)
            let secondTouchArea = touchAreaFromRect(charRects[1], until: textView, textContainerView: textContainerView)
            return firstTouchArea.contains(locationOfTouchInLabel) || secondTouchArea.contains(locationOfTouchInLabel)
        }
        
        let seeMoreOrigin = textContainerView.convert(seeMoreRect.origin, to: textView)
        let textviewSize = textView.frame.size
        
        
        let seeMoreTouchAreaWidth = textviewSize.width - seeMoreOrigin.x
        let seeMoreTouchAreaHeight = textviewSize.height - seeMoreOrigin.y
        
        let seeMoreTouchArea = CGRect(origin: seeMoreOrigin, size: .init(width: seeMoreTouchAreaWidth, height: seeMoreTouchAreaHeight))
        
        let view = UIView(frame: seeMoreTouchArea)
        view.backgroundColor = .red
        textView.addSubview(view)
        textView.layoutIfNeeded()
        
        return seeMoreTouchArea.contains(locationOfTouchInLabel)
    }
    
    private func touchAreaFromRect(_ rect: CGRect, until textView: UITextView, textContainerView: UIView) -> CGRect {
        let seeMoreOrigin = textContainerView.convert(rect.origin, to: textView)
        let textviewSize = textView.frame.size
        
        
        let seeMoreTouchAreaWidth = textviewSize.width - seeMoreOrigin.x
        let seeMoreTouchAreaHeight = textviewSize.height - seeMoreOrigin.y
        
        let seeMoreTouchArea = CGRect(origin: seeMoreOrigin, size: .init(width: seeMoreTouchAreaWidth, height: seeMoreTouchAreaHeight))
        
        let view = UIView(frame: seeMoreTouchArea)
        view.backgroundColor = .red
        textView.addSubview(view)
        textView.layoutIfNeeded()
        
        return seeMoreTouchArea
    }
    
    func checkShowMoreTextTapped(in textView: UITextView) -> Bool {
        let layoutManager = textView.layoutManager
        let textContainer = textView.textContainer
        
        let text = textView.attributedText.string
        
        
        let showMoreText = "showbutton"
        let seeMoreRangeInText = (text as NSString).range(of: showMoreText)
        let seeMoreRect = layoutManager.boundingRect(forGlyphRange: seeMoreRangeInText, in: textContainer)
        
        let textBoundingBox = layoutManager.usedRect(for: textContainer) // text만 들어있는 textBoudning box
        let textContainerView = UIView(frame: textBoundingBox)
        
        let seeMoreOrigin = textContainerView.convert(seeMoreRect.origin, to: textView)
        let textviewSize = textView.frame.size
        
        let seeMoreTouchAreaHeight = textviewSize.height - seeMoreOrigin.y
        
        let seeMoreTouchArea = CGRect(origin: seeMoreRect.origin,
                                      size: .init(width: seeMoreRect.size.width, height: seeMoreTouchAreaHeight))
        
        let locationOfTouchInLabel = self.location(in: textView)
        return seeMoreTouchArea.contains(locationOfTouchInLabel)
    }
}

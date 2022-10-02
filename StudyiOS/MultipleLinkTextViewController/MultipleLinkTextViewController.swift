//
//  MultipleLinkTextViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/08.
//

import UIKit

class MultipleLinkTextViewController: UIViewController {
    private static let oneLineContent = "원라인콘텐츠입니다."
    private static let twoLineContent = "투라인콘텐츠입니다.투라인콘텐츠입니다.투라인콘텐츠입니다.투라인콘텐츠입니다.투라인콘텐츠입니다."
    private static let threeLineContent = "쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다.쓰리라인콘텐츠입니다."
    static let seeMoreContent = "보기"
    
    private let vStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let oneLineTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.isScrollEnabled = false // uitextview는 scroll view이기 때문에, automaticallyAdjustsScrollViewInsets를 zero로 설정하거나, scrollenabled를 false로 해야 한다.
        return $0
    }(UITextView())
    
    private let twoLineTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.isEditable = false
        return $0
    }(UITextView())
    
    private let threeLineTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.text = threeLineContent
        $0.isEditable = false
        return $0
    }(UITextView())
    
    private let newLineTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.attributedText = NSAttributedString("뉴라인뉴라인뉴라인뉴라인뉴라인뉴라인뉴라인뉴라인뉴라인뉴라인뉴라인뉴라인보기")
        $0.isEditable = false
        $0.textContainer.lineFragmentPadding = 0
        return $0
    }(UITextView())
    
    private let oneLineLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = .zero
        return $0
    }(UILabel())
    
    private let twoLineLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = .zero
        return $0
    }(UILabel())
    
    private let threeLineLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = .zero
        return $0
    }(UILabel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        vStackView.addArrangedSubview(oneLineTextView)
        vStackView.addArrangedSubview(twoLineTextView)
        vStackView.addArrangedSubview(threeLineTextView)
        vStackView.addArrangedSubview(newLineTextView)
        
        vStackView.addArrangedSubview(oneLineLabel)
        vStackView.addArrangedSubview(threeLineLabel)
        vStackView.addArrangedSubview(twoLineLabel)
        
        view.addSubview(vStackView)
        
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        setLink()
        
        // MARK: - UITExtView
        
        let recognizerInTextView = UITapGestureRecognizer(target: self, action: #selector(handleTapInTextView(sender:)))
//        twoLineTextView.addGestureRecognizer(recognizerInTextView)
        threeLineTextView.addGestureRecognizer(recognizerInTextView)
        newLineTextView.addGestureRecognizer(recognizerInTextView)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.delegate = self
        oneLineTextView.addGestureRecognizer(tapRecognizer)
        twoLineTextView.addGestureRecognizer(tapRecognizer)
      
        
        // MARK: - UILabel
    
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapInLabel(sender:)))
        threeLineLabel.addGestureRecognizer(recognizer)
        twoLineLabel.addGestureRecognizer(recognizer)
        oneLineLabel.addGestureRecognizer(recognizer)
        
        threeLineLabel.isUserInteractionEnabled = true
        twoLineLabel.isUserInteractionEnabled = true
        oneLineLabel.isUserInteractionEnabled = true
    }
    
    private func setLink() {
//        let oneLineLinkText = "\(Self.oneLineContent) \(Self.seeMoreContent)"
//        let contentRange = NSRange(oneLineLinkText.range(of: Self.oneLineContent)!, in: oneLineLinkText)
//        let seeMoreRange = NSRange(oneLineLinkText.range(of: Self.seeMoreContent)!, in: oneLineLinkText)
//
//
//        let mutable = NSMutableAttributedString(string: oneLineLinkText)
//        mutable.addAttributes([.foregroundColor : UIColor.red,
//                               .link: "toggleAgreement"], range: contentRange)
//        mutable.addAttributes([.foregroundColor : UIColor.blue,
//                               .link: "webView"], range: seeMoreRange)
//
//        oneLineTextView.attributedText = mutable
//        oneLineTextView.sizeToFit()
        let oneLineAttributedText = NSAttributedString(string: "\(Self.oneLineContent) \(Self.seeMoreContent)")
        let twoLineAttributedText = NSAttributedString(string: "\(Self.twoLineContent) \(Self.seeMoreContent)")
        let threeLineAttributedText = NSAttributedString(string: "\(Self.threeLineContent) \(Self.seeMoreContent)")
        
        
        // MARK: - textview
        oneLineTextView.attributedText = oneLineAttributedText
        twoLineTextView.attributedText = twoLineAttributedText
        threeLineTextView.attributedText = threeLineAttributedText
        
        // MARK: - threeLineLabel
        oneLineLabel.attributedText = oneLineAttributedText
        twoLineLabel.attributedText = twoLineAttributedText
        threeLineLabel.attributedText = threeLineAttributedText
    }
    
    @objc func handleTapInLabel(sender: UITapGestureRecognizer) {
        let oneLinePoint = sender.location(in: oneLineLabel)
        let twoLinePoint = sender.location(in: twoLineLabel)
        let threeLinePoint = sender.location(in: threeLineLabel)
        
        let touchOccuredLabel: UILabel
        let content: String

        if oneLinePoint.y > 0 {
            touchOccuredLabel = oneLineLabel
            content = Self.oneLineContent
            print("touchOccuredLabel: oneLineLabel")
        }
        else if twoLinePoint.y > 0 {
            touchOccuredLabel = twoLineLabel
            content = Self.twoLineContent
            print("touchOccuredLabel: twoLineLabel")
        }
        else if threeLinePoint.y > 0 {
            touchOccuredLabel = threeLineLabel
            content = Self.threeLineContent
            print("touchOccuredLabel: threeLineLabel")
        } else {
            return 
        }
        
        let seeMoreRange = (touchOccuredLabel.text! as NSString).range(of: Self.seeMoreContent)
        let contentRange = (touchOccuredLabel.text! as NSString).range(of: content)
        if sender.didTapAttributedTextInLabel(label: touchOccuredLabel, inRange: seeMoreRange) {
            print("see more detected")
        } else if sender.didTapAttributedTextInLabel(label: touchOccuredLabel, inRange: contentRange) {
            print("three line content detected")
        }
    }
    
    @objc func handleTapInTextView(sender: UITapGestureRecognizer) {
        let point = sender.location(in: sender.view)
        let indexPoint = sender.location(ofTouch: 0, in: sender.view)
        let oneTouchPoint = sender.location(in: oneLineTextView)
        let twoTouchPoint = sender.location(in: twoLineTextView)
        let threeTouchPoint = sender.location(in: threeLineTextView)
        
        let touchOccuredLabel: UITextView
        let content: String
        
        
        if oneLineTextView.bounds.contains(oneTouchPoint) {
            touchOccuredLabel = oneLineTextView
            content = Self.oneLineContent
            print("touchOccuredLabel: oneLineTextView")
        }
        else if twoLineTextView.bounds.contains(twoTouchPoint) {
            touchOccuredLabel = twoLineTextView
            content = Self.twoLineContent
            print("touchOccuredLabel: twoLineTextView")
        }
        else if threeLineTextView.bounds.contains(threeTouchPoint) {
            touchOccuredLabel = threeLineTextView
            content = Self.threeLineContent
            print("touchOccuredLabel: threeLineTextView")
        }
        else if newLineTextView.bounds.contains(point) {
            touchOccuredLabel = newLineTextView
            content = newLineTextView.attributedText.string
            print("touchOccuredLabel: newLineTextView")
        }
        else {
            return
        }
        
        let seeMoreRange = (touchOccuredLabel.text! as NSString).range(of: Self.seeMoreContent)
        let contentRange = (touchOccuredLabel.text! as NSString).range(of: content)
        if sender.didTapAttributedTextInLabel(textView: touchOccuredLabel, inRange: seeMoreRange) {
            print("\nsee more detected\n")
        } else if sender.didTapAttributedTextInLabel(textView: touchOccuredLabel, inRange: contentRange) {
            print("\nthree line content detected\n")
        } else {
            print("\nnothing\n")
        }
    }
}

extension MultipleLinkTextViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let tapRecognizer = gestureRecognizer as? UITapGestureRecognizer else {
            return false
        }
        handleTapInTextView(sender: tapRecognizer)
        return true
    }
}

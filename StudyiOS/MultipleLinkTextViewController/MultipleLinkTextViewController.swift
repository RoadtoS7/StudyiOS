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
    private static let seeMoreContent = "보기"
    
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
        $0.text = twoLineContent
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
    
    private var subviews: [UIView] = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        subviews.append(oneLineTextView)
        subviews.append(twoLineTextView)
        subviews.append(threeLineTextView)
        subviews.append(threeLineLabel)
        
        vStackView.addArrangedSubview(oneLineTextView)
        vStackView.addArrangedSubview(twoLineTextView)
        vStackView.addArrangedSubview(threeLineTextView)
        
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
//        let gestureRecognizer = UITapGestureRecognizer()
//        gestureRecognizer.delegate = self
//        threeLineLabel.addGestureRecognizer(gestureRecognizer)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        threeLineLabel.addGestureRecognizer(recognizer)
        twoLineLabel.addGestureRecognizer(recognizer)
        oneLineLabel.addGestureRecognizer(recognizer)
        
        threeLineLabel.isUserInteractionEnabled = true
        twoLineLabel.isUserInteractionEnabled = true
        oneLineLabel.isUserInteractionEnabled = true
    }
    
    private func setLink() {
        let oneLineLinkText = "\(Self.oneLineContent) \(Self.seeMoreContent)"
        let contentRange = NSRange(oneLineLinkText.range(of: Self.oneLineContent)!, in: oneLineLinkText)
        let seeMoreRange = NSRange(oneLineLinkText.range(of: Self.seeMoreContent)!, in: oneLineLinkText)
        
        
        let mutable = NSMutableAttributedString(string: oneLineLinkText)
        mutable.addAttributes([.foregroundColor : UIColor.red,
                               .link: "toggleAgreement"], range: contentRange)
        mutable.addAttributes([.foregroundColor : UIColor.blue,
                               .link: "webView"], range: seeMoreRange)
        
        oneLineTextView.attributedText = mutable
        oneLineTextView.sizeToFit()
        
        
        // MARK: - threeLineLabel
        
        let oneLineAttributedText = NSAttributedString(string: "\(Self.oneLineContent) \(Self.seeMoreContent)")
        let twoLineAttributedText = NSAttributedString(string: "\(Self.twoLineContent) \(Self.seeMoreContent)")
        let threeLineAttributedText = NSAttributedString(string: "\(Self.threeLineContent) \(Self.seeMoreContent)")
        
        oneLineLabel.attributedText = oneLineAttributedText
        twoLineLabel.attributedText = twoLineAttributedText
        threeLineLabel.attributedText = threeLineAttributedText
        threeLineTextView.attributedText = threeLineAttributedText
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let touchOccuredLabel: UILabel
        
        let oneLinePoint = sender.location(in: oneLineLabel)
        let twoLinePoint = sender.location(in: twoLineLabel)
        let threeLinePoint = sender.location(in: threeLineLabel)
        
        if oneLinePoint.y > 0 {
            touchOccuredLabel = oneLineLabel
            print("touchOccuredLabel: oneLineLabel")
        }
        else if twoLinePoint.y > 0 {
            touchOccuredLabel = twoLineLabel
            print("touchOccuredLabel: twoLineLabel")
        }
        else if threeLinePoint.y > 0 {
            touchOccuredLabel = threeLineLabel
            print("touchOccuredLabel: threeLineLabel")
        } else {
            return 
        }
        
        let seeMoreRange = (touchOccuredLabel.text! as NSString).range(of: Self.seeMoreContent)
        let contentRange = (touchOccuredLabel.text! as NSString).range(of: Self.seeMoreContent)
        if sender.didTapAttributedTextInLabel(label: touchOccuredLabel, inRange: seeMoreRange) {
            print("see more detected")
        } else if sender.didTapAttributedTextInLabel(label: touchOccuredLabel, inRange: contentRange) {
            print("three line content detected")
        }
    }
}

extension MultipleLinkTextViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let tapRecognizer = gestureRecognizer as? UITapGestureRecognizer else {
            return false
        }
        
        let seeMoreRange = (threeLineLabel.text! as NSString).range(of: Self.seeMoreContent)
        let contentRange = (threeLineLabel.text! as NSString).range(of: Self.seeMoreContent)
        
        if tapRecognizer.didTapAttributedTextInLabel(label: threeLineLabel, inRange: seeMoreRange) {
            print("see more detected")
            return true
        } else if tapRecognizer.didTapAttributedTextInLabel(label: threeLineLabel, inRange: contentRange) {
            print("three line content detected")
            return true
        } else {
            return false
        }
    }
}

//
//  Main.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/26.
//
// 참조: https://swiftwithmajid.com/2019/01/30/creating-dsl-in-swift/ㅑㅅ

import Foundation

func main() {
    stackview {
        $0.axis = .vertical
        
        $0.label { label in
            label.adjustsFontForContentSizeCategory = true
        }
    }
}

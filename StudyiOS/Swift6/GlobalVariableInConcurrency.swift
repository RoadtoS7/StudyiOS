//
//  GlobalVariableInConcurrency.swift
//  StudyiOS
//
//  Created by 김수현 on 9/1/24.
//

import Foundation

@MainActor var mainActorGlobalVariable  = "enable"

struct MainActorGlobalVariable {
    @MainActor static var enable: Bool = false
}

struct MainActorGlobalConstant {
    static let maximum: Int = 1929
}

nonisolated(unsafe) var candy = ["melon", "orange", "lemon"]

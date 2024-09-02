//
//  InheritActorIsolation.swift
//  StudyiOS
//
//  Created by nylah.j on 8/29/24.
//

import Foundation
import OSLog

func notOnActor(_: @Sendable () async -> Void) { }

actor A {
    var count: Int = 1
  func f() {
    notOnActor {
      await g() // sendable closure이기 때문에 async하게 접근해야 한다.
    }
      
    Task {
        g() // 지금 클로저가 actor-isolated이기 때문에 async하게 접근하지 않는다.
        count += 1 // 지금 클로저가 actor-isolated이기 때문에 actor의 mutable state에 접근 가능
      
    }
  }
  
  func g() { // actor의 메서드 (actor-isolated)
  }
}

class DetachedTaskSample {
   // Task의 우선순위 상속
    func inheritPriority() {
        Task(priority: .high) {
            // 현재 Task는 높은 우선순위로 실행됩니다.
            Task {
                // 이 Unstructured Task는 기존 Task의 우선순위를 상속받아 실행됩니다.
                let value = TaskLocalValues.$myValue.get()
                
            }
        }
    }

    // Task local value 상속
    func inheritLocalVariable() {
        TaskLocalValues.$myValue.withValue("Hellow") {
            Task {
                // Task Local Value를 상속받는다.
                let value = TaskLocalValues.$myValue.wrappedValue
                print("Inherited Task-local value: \(value)")
            }
        }
    }
}

enum TaskLocalValues {
    @TaskLocal static var myValue: String = ""
}

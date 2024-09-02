//
//  Actor.swift
//  StudyiOS
//
//  Created by nylah.j on 5/21/24.
//

// 개발자가 직접 lock 처리를 하지 않아도 자동으로 lock 처리를 해주는 타입
// Actor: reference type


import Foundation

actor CounterActor {
    var count = 0
    var maximum = 0
    
    func increment() {
     self.count += 1
     self.maximum = max(self.count, self.maximum)
     }
    func decrement() {
     self.count -= 1
     }
    
  
}

enum CounterActorTest {
    
    static func test() {
        let counter = CounterActor()
        let workCount = 1000
        
        for _ in 0..<workCount {
            Task {
                await counter.increment() // actor 에서 자동으로 동기화를 해준다.
            }
        }
    }
    
    
    // 그래서 그 유명한 Actor isoation이 무엇이에요?
    // actor isolation으로 인해서 actor의 프로퍼티에 접근할 때는 무조건 await을 붙여주어야 해요!
    static func accessProperty() {
        let counter = CounterActor()
        Task {
            await print("$$ counter count: ", counter.count)
            await print("$$ counter maximum: ", counter.maximum)
        }
    }
    
    static func nonDeterminsim() {
        let counter = CounterActor()
//        print("$$ counter count: ", counter.count) 
//        print("$$ counter maximum: ", counter.maximum)
    }
}






//
//  Sendable.swift
//  StudyiOS
//
//  Created by nylah.j on 5/21/24.
//

import Foundation

/**
 Sendable은 프로토콜입니다.
 public protocol Sendable {}
 
 언제 사용? concurrent 환경에서 안전한 타입을 의미한다.
 = race condition을 일으키지 않는다.
 = concurrent bound를 넘나들며 사용가능하다.
 
 value타입은 자동으로 준수한다. ex) Int, User
 아닌 타입도 있다! ex) AttributedString
 */

struct User: Sendable {
    var id: Int
    var name: String
    var bio: AttributedString // Not Sendable!!
}

// reference type 에서는 mutable한 프로퍼티를 가지면, Sendable을 준수해도 wraning이 발생한다.
class UserClass: Sendable  {
    var id: Int // mutable
    var name: String // mutable
    
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

// reference type이 Sedable이기 위해서? 1) final 2) non-mutable한 프로퍼티
final class RightSendable: Sendable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
// 그럼 struct하고 다를게 없잖아요!!!
// 컴파일러가 안전하다고 판별하지 않지만 - 우리가 concurrent에서 안전하게 사용할 거라는 믿음이 있다면? @unchecked Sendable을 사용해라~
// 꼭꼭 동기화를 해주어야 겠지!!
class UnchckedCounteer: @unchecked Sendable {
    let lock = NSLock()
    var count: Int = .zero
    
    func increment() {
        lock.lock()
        defer {
            lock.unlock()
        }
        count += 1
    }
}

/**
 ///  Escaping closure와 asynchoronous operations
 ///  escaping closure의 특징: 저장해두었다가 나중에 실행될 수 있다~
 func perform(work: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
  work()
  }
 }
 */


/**
 Sendable한 클로저? 서로 다른 context를 넘나들며 실행될 수 있는 클로저
 조건? race condition을 일으키지 않는다. - mutable variable에 접근하지 않는다.
 
 func perform(work: @escaping @Sendable () -> Void) {
     Task {
        work()
    }
 }
  
 */

// 주의해야 하는 코드!!!!
// 서로다른 Task (concurrent context)에서 실행되는 closure라면 꼭꼭 sendable이어야 한다.
struct DatabaseClient {
    var fetchUser: () async throws -> [User]
    var createUser: (User) async throws -> Void
}

func testDatabaseClient(client: DatabaseClient, work: @escaping @Sendable () -> Void) {
    Task {
        _ = try await client.fetchUser() // 아래와 다른 실행 context에서 실행되기 때문에 sendable이어야 한다!!!
        
    }
    
    Task {
        _ = try await client.fetchUser()
    }
}






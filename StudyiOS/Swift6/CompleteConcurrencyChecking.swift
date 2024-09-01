//
//  CompleteConcurrencyChecking.swift
//  StudyiOS
//
//  Created by 김수현 on 9/1/24.
//

import SwiftUI

class Swift6User {
    var name: String
    
    init()  {
        name = ""
    }
}


struct CompleteConcurrencyChecking: View {
    var body: some View {
        Text("Hello, World!")
            .task {
                let user = Swift6User()
                await loadData(for: user)
            }
    }
    
    func loadData(for user: Swift6User) async {
        print("Loading data for \(user.name)…")
    }
}

@MainActor
class Swift6ViewModel {
    func loadData(for user: Swift6User) async {
        print("Loading data for \(user.name)…")
    }
}

#Preview {
    CompleteConcurrencyChecking()
}

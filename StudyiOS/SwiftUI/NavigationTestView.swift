//
//  NavigationTestView.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/08/01.
//

import SwiftUI

struct NavigationTestView: View {
    var body: some View {
        NavigationView {
            GeometryReader { gemotry in
                VStack {
                    Text("Hello, World!")
                        .foregroundColor(.white)
                    
                    NavigationLink {
                        NavigationDestinationView()
                    } label: {
                        Label("Work Folder", systemImage: "folder")
                    }
                }
                .frame(width: gemotry.size.width, height: gemotry.size.height)
                .background(Color.red)
            }
        }
    }
}

struct NavigationDestinationView: View {
    var body: some View {
        ZStack {
            NavigationLink {
                NestedDestinationView()
            } label: {
                Text("navigate to nested view")
            }

        }
    }
}

struct NestedDestinationView: View {
    var body: some View {
        ZStack {
            Text("finally!!! ")
        }
        .navigationBarBackButtonHidden() // 위로 사라지는 애니메이션
//        .navigationBarHidden(true) //  위로 사라지는 애니메이션
    }
}
struct NavigationTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView()
    }
}

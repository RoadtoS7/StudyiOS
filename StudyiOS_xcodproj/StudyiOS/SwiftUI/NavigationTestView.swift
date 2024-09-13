//
//  NavigationTestView.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/08/01.
//
// 네비게이션을 통해 화면 트랜지션을 할경우 NavigationLink만 만들어주면 된다.
// 네비게이션 Link 버튼의 style은 ButtonStyle을 통해 수정할 수 있다.

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
                    .padding(.horizontal, 16)
                    .buttonStyle(NavigationLinkButtonStyle())
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
            .padding(.horizontal, 16)
            .buttonStyle(NavigationLinkButtonStyle())
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

struct NavigationLinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: 48)
            .background(Color.yellow)
            .foregroundColor(Color.green)
            .cornerRadius(10)
    }
}
struct NavigationTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView()
    }
}

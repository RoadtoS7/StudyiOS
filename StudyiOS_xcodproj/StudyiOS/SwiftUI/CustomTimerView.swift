//
//  CustomTimerView.swift
//  StudyiOS
//
//  Created by nylah.j on 5/9/24.
//

import SwiftUI

struct CustomTimerView: View {
    let totalSeconds: Int
    @State private var secondsLeft: Int
    
    init(seconds: Int) {
        self.totalSeconds = seconds
        self._secondsLeft = State(initialValue: seconds)
    }
    
    var body: some View {
        if #available(iOS 17.0, *) {
            Text(displayTime(seconds: secondsLeft))
                .font(.largeTitle)
                .onAppear(perform: {
                    runTimer()
                })
                .onChange(of: secondsLeft) { oldValue, newValue in
                    withAnimation {
                        runTimer()
                    }
                }
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            if secondsLeft > 0 {
                secondsLeft -= 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func displayTime(seconds: Int) -> String {
        if seconds <= .zero {
            return "Done"
        } else if seconds < 60 {
            return "\(seconds) secs"
        } else {
            let minutes = seconds / 60
            return "\(minutes) mins"
        }
    }
}

#Preview {
    CustomTimerView(seconds: 120)
}

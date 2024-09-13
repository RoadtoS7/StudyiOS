//
//  FromGCDToTask.swift
//  StudyiOS
//
//  Created by nylah.j on 8/27/24.
//

import Foundation
import UIKit
import OSLog

final class FromGCDToTaskViewController: UIViewController {
    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainActorRun()
        yeildTask()
        
        Task {
            let message = mainThreadCheckMessage()
            logger.log("$$ viewDidLoad - Task 안쪽 - \(message)") // $$ viewDidLoad - Task 안쪽 - on MainThread
            let result = await callerAwaitTaskValue()
            logger.log("$$ await Task value: \(result)")
        }
        
        runDetachTask()
    }
    
    private func mainActorRun() {
        let message = mainThreadCheckMessage()
        logger.log("$$ mainActorRun: \(message)") // $$ mainActorRun: on MainThread
        Task {
            let message1 = mainThreadCheckMessage()
            logger.log("$$ mainActorRun - Task : \(message1)") // $$ mainActorRun - Task : on MainThread
            await MainActor.run {
                let message2 = mainThreadCheckMessage()
                logger.log("$$ mainActorRun - MainACtor.run: \(message2)")
                syncCall()
            }
        }
    }
    
    private func yeildTask() {
        let message = mainThreadCheckMessage()
        logger.log("$$ yeildTask - \(message)") // $$ yeildTask - on MainThread
        Task {
            let message1 = mainThreadCheckMessage()
            logger.log("yeildTask - before yeild - \(message1)") // yeildTask - before yeild - on MainThread
            await Task.yield()
            let message2 = mainThreadCheckMessage()
            logger.log("yeildTask - after yeild - \(message2)")
            syncCall()
        }
    }
    
    private func callerAwaitTaskValue() async -> Bool {
        let message = mainThreadCheckMessage()
        logger.log("callerAwaitTaskValue before await - \(message)") // callerAwaitTaskValue before await - on MainThread
        
        let result = await awaitTaskValue() // await를 만나더라도, 내부에 Thread를 yeild해야 하는 상황이 올때까지는 계속 진행한다.
        
        let message2 = mainThreadCheckMessage()
        logger.log("callerAwaitTaskValue before await - \(message2)")
        return result
    }
    
    private func awaitTaskValue() async -> Bool {
        let message = mainThreadCheckMessage()
        logger.log("awaitTaskValue - \(message)") // awaitTaskValue - on MainThread
        let task = Task {
            let message2 = mainThreadCheckMessage()
            logger.log("awaitTaskValue - Task 내부 - \(message2)")
            return syncCall()
        }
        return await task.value // await task.value는 비동기로 축적된다.
    }
    
    @discardableResult
    private func syncCall() -> Bool{
        return true
    }
    
    private func runDetachTask() {
        Task.detached {
            let message = mainThreadCheckMessage()
            self.logger.log("$$ runDetachTask  - \(message)") // $$ runDetachTask  - not on MainThread
        }
    }
    
    func goTo() {
        DispatchQueue.main.async {
            self.syncCall()
        }
    }
}

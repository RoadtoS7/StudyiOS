//
//  TouchableResponderView.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/12/27.
//

import UIKit


class TouchableResponderView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        touches.forEach { touch in
            print("altitudeAngle: \(touch.altitudeAngle)")
            print("force: \(touch.force)")
            print("majorRadius: \(touch.majorRadius)")
            print("maximumPossibleForce: \(touch.maximumPossibleForce)")
            print("tapCount: \(touch.tapCount)")
            print("majorRadiusTolerance: \(touch.majorRadiusTolerance)")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
    }
}

//
//  StudyUIViewViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/04/19.
//

import UIKit
import OSLog

class StudyUIViewViewController: UIViewController {
    private var sizeToFitLabel: UILabel!
    let logger = Logger()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("$$ viewDidLoad")

        // Do any additional setup after loading the view.
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        logger.log("$$ viewIsAppearing")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.log("$$ viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logger.log("$$ viewDidAppear")
    }
}



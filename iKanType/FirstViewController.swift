//
//  FirstViewController.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/12/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit
import Keyboard
import ObjectMapper

class FirstViewController: UIViewController {
    @IBOutlet var backgroundView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let color = Mapper<AJGradientColor>().map("{ \"colors\": [{\"red\": 250.0, \"green\": 109.0, \"blue\": 69.0, \"alpha\": 1.0}, {\"red\": 230.0, \"green\": 58.0, \"blue\": 91.0, \"alpha\": 1.0}], \"locations\": [0.0, 1.0] }")
//        
//        self.view.gradientBackground(color);
//        self.backgroundView!.image = UIImage(named: "gradient")
        self.backgroundView!.contentMode = .scaleAspectFill

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


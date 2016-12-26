//
//  ButtonViewController.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/14/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topImageHeightConstraint: NSLayoutConstraint!
    var keyAlignment: KeyAlignmentType! {
        didSet{
            var topImage: UIImage? = nil
            var bottomImage: UIImage? = nil
            // Image with cap insets
            switch keyAlignment! {
            case .LeftKey:
                topImage = UIImage(named: "LeftKeyTop")!.resizableImage(withCapInsets: UIEdgeInsetsMake(15, 10, 0, 10))
                bottomImage = UIImage(named: "LeftKeyBottom")!.resizableImage(withCapInsets: UIEdgeInsetsMake(30, 6, 8, 32))
            case .RightKey:
                topImage = UIImage(named: "RightKeyTop")!.resizableImage(withCapInsets: UIEdgeInsetsMake(15, 10, 0, 10))
                bottomImage = UIImage(named: "RightKeyBottom")!.resizableImage(withCapInsets: UIEdgeInsetsMake(30, 32, 8, 6))
            case .NormalKey:
                topImage = UIImage(named: "KeyTop")!.resizableImage(withCapInsets: UIEdgeInsetsMake(15, 10, 0, 10))
                bottomImage = UIImage(named: "KeyBottom")!.resizableImage(withCapInsets: UIEdgeInsetsMake(20, 20, 8, 20))
            }
            
            let topImageForRendering: UIImage = topImage!.withRenderingMode(.alwaysTemplate)
            self.topImageView.image = topImageForRendering
            let bottomImageForRendering: UIImage = bottomImage!.withRenderingMode(.alwaysTemplate)
            self.bottomImageView.image = bottomImageForRendering
            self.topImageView.tintColor = self.keyColor
            self.bottomImageView.tintColor = self.keyColor
        }
    }
    
    var keyColor: UIColor! {
        didSet{
            self.topImageView.tintColor = self.keyColor
            self.bottomImageView.tintColor = self.keyColor
        }
    }
    
    convenience override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        self.topImageHeightConstraint.constant = self.view.frame.size.height / 4
        super.updateViewConstraints()
    }
    
    //MARK: - Button Frame
    class func CreateFrameForButton(button: UIButton, withAlignment alignment: KeyAlignmentType) -> CGRect {
        var frame: CGRect
        switch alignment {
        case .NormalKey:
            frame = CGRect(x: button.frame.origin.x - 12, y: button.frame.origin.y - 1.5 * button.frame.size.height, width: button.frame.size.width + 25, height: button.frame.size.height * 2.5)
        case .LeftKey:
            frame = CGRect(x: button.frame.origin.x, y: button.frame.origin.y - 1.5 * button.frame.size.height, width: button.frame.size.width + 26, height: button.frame.size.height * 2.5)
        case .RightKey:
            frame = CGRect(x: button.frame.origin.x - 26, y: button.frame.origin.y - 1.5 * button.frame.size.height, width: button.frame.size.width + 26, height: button.frame.size.height * 2.5)
        }
        
        return frame
    }
}

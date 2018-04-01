//
//  GameViewController.swift
//  Pong
//
//  Created by Artyom Dangizyan on 1/16/15.
//  Copyright (c) 2015 Artyom Dangizyan. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            let skView = self.view as! SKView
            skView.isMultipleTouchEnabled=true;
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            scene.size = skView.bounds.size
            skView.presentScene(scene)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}

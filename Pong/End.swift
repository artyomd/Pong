//
//  End.swift
//  Pong
//
//  Created by Artyom Dangizyan on 12/18/14.
//  Copyright (c) 2014 Artyom Dangizyan. All rights reserved.
//

import SpriteKit

class End: SKScene {
    
    var finalLabel=SKLabelNode(fontNamed: GameScene.FUTURA_MEDIUM_FONT)
    var tryAgain = SKLabelNode(text: "tap to play again");
    var home = SKSpriteNode(imageNamed: "home");
    let homeNodeName = "home";
    var muiltyplayer:Bool = Bool();
    
    init(size: CGSize,finalText:String, muiltyplayer:Bool) {
        super.init(size: size);
        finalLabel.text=finalText;
        self.muiltyplayer=muiltyplayer;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func sceneDidLoad() {
        self.backgroundColor = SKColor.black;
        finalLabel.fontColor = SKColor.white;
        finalLabel.fontSize = 44;
        self.addChild(finalLabel);
        
        tryAgain.fontColor = SKColor.white;
        tryAgain.fontName = GameScene.FUTURA_MEDIUM_FONT;
        tryAgain.fontSize = 24;
        self.addChild(tryAgain);
        
        home.name=homeNodeName;
        self.addChild(home);
    }
    
    override func didMove(to view: SKView){
        if(UserDefaults.standard.bool(forKey: GameScene.SOUND_VALUE_KEY))
        {
            let play = SKAction.playSoundFileNamed("gameover.caf", waitForCompletion: false);
            self.run(play);
        }
        
        finalLabel.position = CGPoint(x: self.frame.midX,y: self.frame.midY);
        
        tryAgain.position = CGPoint(x: size.width/2, y: -50);
        tryAgain.run(SKAction.moveTo(y: size.height/2 - 40, duration: 2.0))
        home.position=CGPoint(x: self.size.width*15/16, y: self.size.height * 1/16);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first;
        let location = touch?.location(in: self);
        let node = self.atPoint(location!);
        let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
        switch (node.name) {
        case homeNodeName:
            
            let menu = GameScene(size: self.size);
            menu.showSoundDialog(show: false);
            self.view?.presentScene(menu, transition: reveal)
            break;
        default:
            let game = Pong(size: self.size, muilplayer: self.muiltyplayer);
            self.view?.presentScene(game, transition: reveal)
            break;
        }
    }
}

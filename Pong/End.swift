//
//  End.swift
//  Pong
//
//  Created by Artyom Dangizyan on 12/18/14.
//  Copyright (c) 2014 Artyom Dangizyan. All rights reserved.
//

import SpriteKit

class End: SKScene {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var label=SKLabelNode(fontNamed: "Futura Medium")
    var muiltyplayer:Bool = Bool();
    var vspeed:Int16;
    var vdif:Int16;
    var vsound:Bool;
    init(size: CGSize,ltext:String, muiltyplayer:Bool,difficluty: Int16,speed: Int16,sound: Bool) {
        label.text=ltext;
        self.muiltyplayer=muiltyplayer;
        vspeed=speed;
        vdif=difficluty;
        vsound=sound;
        super.init(size: size);
      
    }
    
    override func didMove(to view: SKView){
        self.backgroundColor = SKColor.black;
        
        if(vsound)
        {
        let play = SKAction.playSoundFileNamed("gameover.caf", waitForCompletion: false);
        self.run(play);
        }
        label.fontColor = SKColor.white;
        label.fontSize = 44;
        label.position = CGPoint(x: self.frame.midX,y: self.frame.midY);
        self.addChild(label);
        
        let tryAgain = SKLabelNode(fontNamed: "Futura Medium");
        tryAgain.text = "tap to play again";
        tryAgain.fontColor = SKColor.white;
        tryAgain.fontSize = 24;
        tryAgain.position = CGPoint(x: size.width/2, y: -50);
        
        let moveLabel = SKAction.moveTo(y: size.height/2 - 40, duration: 2.0);
        tryAgain.run(moveLabel)
        
        self.addChild(tryAgain);
        
        let home = SKSpriteNode(imageNamed: "home");
        home.position=CGPoint(x: size.height * 8/16, y: size.width * 1/16+30);
        home.physicsBody = SKPhysicsBody(rectangleOf: home.frame.size);
        home.physicsBody?.isDynamic = false;
        home.name="home";
        self.addChild(home);
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first;
        let location = touch?.location(in: self);
        let node = self.atPoint(location!);
        if(node.name=="home")
        {
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
            let menu = GameScene(size: self.size);
            menu.addSettings( vdif, speed: vspeed, sound: vsound, start:true);
            self.view?.presentScene(menu, transition: reveal)
        }
        else
        {
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
            let game = Pong(size: self.size, muilplayer: self.muiltyplayer, difficluty: vdif, speed: vspeed, sound: vsound);
            self.view?.presentScene(game, transition: reveal)
        
        }

    }
}

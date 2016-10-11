//
//  GameScene.swift
//  Pong
//
//  Created by Artyom Dangizyan on 1/16/15.
//  Copyright (c) 2015 Artyom Dangizyan. All rights reserved.
//


import SpriteKit
import CoreData


class GameScene: SKScene, SKPhysicsContactDelegate
{
    var tittle:SKLabelNode=SKLabelNode(text: "Pong");
    var fplayer:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var splayer:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var back:SKSpriteNode=SKSpriteNode(imageNamed: "back");
    var settings:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var difficulty:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var bSpeed:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var sound:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var sON:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var sOFF:SKLabelNode=SKLabelNode(fontNamed: "Futura Medium");
    var sslow=SKLabelNode(fontNamed: "Futura Medium");
    var snormal=SKLabelNode(fontNamed: "Futura Medium");
    var sfast=SKLabelNode(fontNamed: "Futura Medium");
    var deasy=SKLabelNode(fontNamed: "Futura Medium");
    var dnormal=SKLabelNode(fontNamed: "Futura Medium");
    var dhard=SKLabelNode(fontNamed: "Futura Medium");
    var vDifficulty:Int16 = 2;
    var vSpeed:Int16 = 2;
    var vSound:Bool = true;
    var bSound = SKSpriteNode(imageNamed: "sound");
    var sTrue = SKSpriteNode(imageNamed: "true");
    var sfalse = SKSpriteNode(imageNamed: "false");
    var choosed = false;
    
    func addSettings(_ difficluty: Int16,speed: Int16,sound: Bool, start: Bool)
    {
        choosed=start;
        vSpeed=speed;
        vDifficulty=difficluty;
        vSound=sound;
    }
    
    
    
    override func didMove(to view: SKView){
        backgroundColor = SKColor.black;
       
        tittle.fontColor = SKColor.white;
        tittle.fontSize = 44;
        tittle.fontName="Futura-Medium"
        tittle.position = CGPoint(x: self.frame.midX,y: self.size.height*(1.5));
        self.addChild(tittle)
        
        fplayer.text = "1 Player";
        fplayer.name = "1 Player";
        fplayer.fontColor = SKColor.white;
        fplayer.fontSize = 40;
        fplayer.position = CGPoint(x: size.height * 15/16,y: size.height * 2/4 + 40);
        self.addChild(fplayer);
        
        
        splayer.text = "2 Player";
        splayer.name = "2 Player";
        splayer.fontColor = SKColor.white;
        splayer.fontSize = 40;
        splayer.position = CGPoint(x: -size.height * 1/2,y: size.height * 2/4 - 40);
        self.addChild(splayer);
        
        
        back.position = CGPoint(x: size.height * 15/16, y: (size.width * 1/16 + 30));
        back.physicsBody = SKPhysicsBody(rectangleOf: back.frame.size);
        back.physicsBody?.isDynamic = false;
        back.name = "back";
        back.zRotation = atan2(0,-200);
        self.addChild(back);
        
        settings.text="Settings"
        settings.name="Settings"
        settings.fontColor=SKColor.white;
        settings.fontSize = 40;
        settings.position = CGPoint(x: size.width/2, y: -50);
        addChild(settings);
        
        
        difficulty.text="Difficulty";
        difficulty.fontSize=30;
        difficulty.color=SKColor.white;
        difficulty.position=CGPoint(x: -self.size.width/2, y: self.size.height*12/16);
        addChild(difficulty);
        
        bSpeed.text="Ball Speed";
        bSpeed.fontSize=30;
        bSpeed.color=SKColor.white;
        bSpeed.position=CGPoint(x: -self.size.width/2, y: self.size.height*8/16);
        addChild(bSpeed);
        
        sound.text="Sound";
        sound.fontSize=30;
        sound.color=SKColor.white;
        sound.position=CGPoint(x: -self.size.width/2, y: self.size.height*5/16);
        addChild(sound);
        
        sON.text="ON";
        sON.fontSize=30;
        sON.name="sON";
        sON.color=SKColor.white;
        sON.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        addChild(sON);
        
        sOFF.text="OFF";
        sOFF.fontSize=30;
        sOFF.name="sOFF";
        sOFF.color=SKColor.white;
        sOFF.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        addChild(sOFF);
        
        sslow.text="slow";
        sslow.fontSize=30;
        sslow.name="sslow";
        sslow.color=SKColor.white;
        sslow.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        addChild(sslow);
        
        snormal.text="normal";
        snormal.fontSize=30;
        snormal.name="snormal"
        snormal.color=SKColor.white;
        snormal.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        addChild(snormal);
        
        sfast.text="fast";
        sfast.fontSize=30;
        sfast.name="sfast";
        sfast.color=SKColor.white;
        sfast.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        addChild(sfast);
        
        deasy.text="easy";
        deasy.fontSize=30;
        deasy.name="deasy";
        deasy.color=SKColor.white;
        deasy.position=CGPoint(x: self.size.width*0.7, y: self.size.height*1.5);
        addChild(deasy);
        
        dnormal.text="normal";
        dnormal.fontSize=30;
        dnormal.name="dnormal";
        dnormal.color=SKColor.white;
        dnormal.position=CGPoint(x: self.size.width*0.7, y: self.size.height*1.5);
        addChild(dnormal);
        
        dhard.text="hard";
        dhard.fontSize=30;
        dhard.name="dhard";
        dhard.color=SKColor.white;
        dhard.position=CGPoint(x: self.size.width*0.7, y: self.size.height*1.5);
        addChild(dhard);
        
        bSound.position = CGPoint(x: self.size.width/2, y: self.size.height*1.5);
        bSound.name = "bSound";
        self.addChild(bSound);
        
        sTrue.position = CGPoint(x: self.size.width*(-0.5), y: self.size.height*(0.05));
        sTrue.name = "sTrue";
        self.addChild(sTrue);

        sfalse.position = CGPoint(x: self.size.width*(1.5), y: self.size.height*(0.05));
        sfalse.name = "sfalse";
        self.addChild(sfalse);
        
        
        if(choosed)
        {
            tittle.run(SKAction.moveTo(y: (self.size.height * 7/8), duration:2.0));
            fplayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            splayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            back.run(SKAction.moveTo(x: self.size.height * 15/16, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            difficulty.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            bSpeed.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            sound.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            sON.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            sOFF.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            sslow.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            sfast.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            snormal.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            deasy.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            dhard.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            dnormal.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
        }
        else
        {
            sTrue.run(SKAction.moveTo(x: size.width*(0.1), duration: 2.0));
            bSound.run(SKAction.moveTo(y: size.height/2, duration: 2.0));
            sfalse.run(SKAction.moveTo(x: size.width*(0.9), duration: 2.0));
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first;
        let location = touch?.location(in: self);
        let node = self.atPoint(location!);
        
        if(node.name=="back")
        {
            tittle.run(SKAction.moveTo(y: (self.size.height * 7/8), duration:2.0));
            fplayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            splayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            back.run(SKAction.moveTo(x: self.size.height * 15/16, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            difficulty.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            bSpeed.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            sound.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            sON.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            sOFF.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            sslow.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            sfast.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            snormal.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            deasy.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            dhard.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            dnormal.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
        }
        else if(node.name=="sTrue")
        {
            vSound=true
            tittle.run(SKAction.moveTo(y: size.height*0.9, duration: 2.0))
            fplayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            splayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            bSound.run(SKAction.moveTo(y: size.height*1.5, duration: 2.0));
            sTrue.run(SKAction.moveTo(x: self.size.width*(-0.5), duration: 2.0));
            sfalse.run(SKAction.moveTo(x: self.size.width*(1.5), duration: 2.0));

        }
        else if(node.name=="sfalse")
        {
            vSound=false
            tittle.run(SKAction.moveTo(y: size.height*0.9, duration: 2.0))
            fplayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            splayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            bSound.run(SKAction.moveTo(y: size.height*1.5, duration: 2.0));
            sTrue.run(SKAction.moveTo(x: self.size.width*(-0.5), duration: 2.0));
            sfalse.run(SKAction.moveTo(x: self.size.width*(1.5), duration: 2.0));
            
        }
        else if(node.name=="1 Player")
        {
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 1)
            let game = Pong(size: self.size, muilplayer: false, difficluty: vDifficulty, speed: vSpeed, sound: vSound);
            self.view?.presentScene(game, transition: reveal)
            
        }
        else if(node.name=="2 Player")
        {
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 1);
            let game = Pong(size: self.size, muilplayer: true, difficluty: vDifficulty, speed: vSpeed, sound: vSound);
            self.view?.presentScene(game, transition: reveal)
        }
        else if(node.name=="Settings")
        {
            tittle.run(SKAction.moveTo(y: (self.size.height * 1.5), duration:2.0));
            fplayer.run(SKAction.moveTo(x: self.size.height * 15/16, duration: 2.0));
            splayer.run(SKAction.moveTo(x: -self.size.height * 15/16, duration: 2.0));
            settings.run(SKAction.moveTo(y: self.size.height * 7.2/8, duration: 2.0));
            back.run(SKAction.moveTo(x: size.height * 1/16, duration: 2.0));
            difficulty.run(SKAction.moveTo(x: self.size.width*0.25, duration: 2.0));
            bSpeed.run(SKAction.moveTo(x: self.size.width*0.25, duration: 2.0));
            sound.run(SKAction.moveTo(x: self.size.width*0.25, duration: 2.0));
            sON.run(SKAction.moveTo(y: self.size.height*5.5/16, duration: 2.0));
            sOFF.run(SKAction.moveTo(y: self.size.height*4.5/16, duration: 2.0));
            sslow.run(SKAction.moveTo(y: self.size.height*9/16, duration: 2.0));
            sfast.run(SKAction.moveTo(y: self.size.height*7/16, duration: 2.0));
            snormal.run(SKAction.moveTo(y: self.size.height*8/16, duration: 2.0));
            deasy.run(SKAction.moveTo(y: self.size.height*13/16, duration: 2.0));
            dhard.run(SKAction.moveTo(y: self.size.height*11/16, duration: 2.0));
            dnormal.run(SKAction.moveTo(y: self.size.height*12/16, duration: 2.0));
        }
        else if(node.name=="sON")
        {
            self.vSound=true;
        }
        else if(node.name=="sOFF")
        {
            self.vSound=false;
        }
        else if(node.name=="sslow")
        {
            self.vSpeed=1;
        }
        else if(node.name=="snormal")
        {
            self.vSpeed=2;
        }
        else if(node.name=="sfast")
        {
            self.vSpeed=3;
        }
        else if(node.name=="deasy")
        {
            self.vDifficulty=1;
        }
        else if(node.name=="dnormal")
        {
            self.vDifficulty=2;
        }
        else if(node.name=="dhard")
        {
            self.vDifficulty=3;
        }
        
        
    }
    override func update(_ currentTime: TimeInterval) {
        
        if(vSound)
        {
            sOFF.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            sON.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
        }
        else
        {
            sON.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            sOFF.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
        }
        
        if(vSpeed==1)
        {
            sslow.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
            snormal.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            sfast.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
        }
        else if(vSpeed==2)
        {
            sslow.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            snormal.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
            sfast.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
        }
        else if(vSpeed==3)
        {
            sslow.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            snormal.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            sfast.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
            
        }
        
        if(vDifficulty==1)
        {
            deasy.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
            dnormal.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            dhard.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            
        }
        else if(vDifficulty==2)
        {
            deasy.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            dnormal.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
            dhard.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            
        }
        else if(vDifficulty==3)
        {
            deasy.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            dnormal.fontColor=SKColor(red: 255, green: 255, blue: 255, alpha: 1);
            dhard.fontColor=SKColor(red: 255, green: 0, blue: 0, alpha: 1);
            
            
        }
        
    }
    
    
    
}

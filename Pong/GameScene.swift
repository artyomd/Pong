//
//  GameScene.swift
//  Pong
//
//  Created by Artyom Dangizyan on 1/16/15.
//  Copyright (c) 2015 Artyom Dangizyan. All rights reserved.
//


import SpriteKit

class GameScene: SKScene
{
    static let FUTURA_MEDIUM_FONT:String = "Futura Medium";
    static let BALL_SPEED_VALUE_KEY = "speed value";
    static let SOUND_VALUE_KEY = "sound value";
    static let DIFFICULTY_VALUE_KEY = "difficluty value";
    
    let onePlayerName:String = "1 player";
    let twoPlayerName:String = "2 player";
    let settingsName:String = "settings";
    let soundOnName:String = "sound on"
    let soundOffName:String = "sound off"
    let speedSlowName:String = "speed slow";
    let speedNormalName:String = "speed normal";
    let speedFastName:String = "speed fast";
    let difficultyEasyName:String="difficulty easy";
    let difficultyNormalName:String="difficulty normal";
    let difficultyHardName:String="difficulty hard";
    let backName:String = "back";
    let trueImageName:String = "true image";
    let falseImageName:String = "false image";
    
    var tittle:SKLabelNode=SKLabelNode(text: "Pong");
    var onePlayer:SKLabelNode=SKLabelNode(text:"1 Player");
    var twoPlayer:SKLabelNode=SKLabelNode(text: "2 Player");
    var settings:SKLabelNode=SKLabelNode(text: "Settings");
    var difficulty:SKLabelNode=SKLabelNode(text: "Difficulty");
    var ballSpeed:SKLabelNode=SKLabelNode(text: "Ball Speed");
    var sound:SKLabelNode=SKLabelNode(text: "Sound");
    var soundOn:SKLabelNode=SKLabelNode(text: "on");
    var soundOff:SKLabelNode=SKLabelNode(text:"off");
    var speedSlow=SKLabelNode(text:"slow");
    var speedNormal=SKLabelNode(text: "normal");
    var speedFast=SKLabelNode(text: "fast");
    var difficultyEasy=SKLabelNode(text: "easy");
    var difficultyNormal=SKLabelNode(text:"normal");
    var difficultyHard=SKLabelNode(text: "hard");
    var soundImage = SKSpriteNode(imageNamed: "sound");
    var trueImage = SKSpriteNode(imageNamed: "true");
    var falseImage = SKSpriteNode(imageNamed: "false");
    var back:SKSpriteNode=SKSpriteNode(imageNamed: "back");
    
    var difficultyValue:Int16 = 0;
    var ballSpeedValue:Int16 = 0;
    var soundEnabled:Bool = false;
    var showSoundDialog = true;
    
    override func sceneDidLoad() {
        super.sceneDidLoad();
        
        backgroundColor = SKColor.black;
        
        tittle.fontColor = SKColor.white;
        tittle.fontSize = 44;
        tittle.fontName=GameScene.FUTURA_MEDIUM_FONT;
        self.addChild(tittle)
        
        onePlayer.fontColor = SKColor.white;
        onePlayer.name = onePlayerName;
        onePlayer.fontName = GameScene.FUTURA_MEDIUM_FONT;
        onePlayer.fontSize = 40;
        self.addChild(onePlayer);
        
        twoPlayer.name = twoPlayerName;
        twoPlayer.fontColor = SKColor.white;
        twoPlayer.fontName = GameScene.FUTURA_MEDIUM_FONT;
        twoPlayer.fontSize = 40;
        self.addChild(twoPlayer);
        
        settings.name = settingsName;
        settings.fontName = GameScene.FUTURA_MEDIUM_FONT;
        settings.fontColor=SKColor.white;
        settings.fontSize = 40;
        addChild(settings);
        
        difficulty.fontSize=30;
        difficulty.color=SKColor.white;
        difficulty.fontName = GameScene.FUTURA_MEDIUM_FONT;
        addChild(difficulty);
        
        ballSpeed.fontSize=30;
        ballSpeed.color=SKColor.white;
        ballSpeed.fontName = GameScene.FUTURA_MEDIUM_FONT;
        addChild(ballSpeed);
        
        sound.fontSize=30;
        sound.color=SKColor.white;
        sound.fontName = GameScene.FUTURA_MEDIUM_FONT;
        addChild(sound);
        
        soundOn.fontSize=30;
        soundOn.name = soundOnName;
        soundOn.fontName = GameScene.FUTURA_MEDIUM_FONT;
        soundOn.color=SKColor.white;
        addChild(soundOn);
        
        soundOff.fontSize=30;
        soundOff.name=soundOffName;
        soundOff.fontName = GameScene.FUTURA_MEDIUM_FONT;
        soundOff.color=SKColor.white;
        addChild(soundOff);
        
        speedSlow.fontSize=30;
        speedSlow.name=speedSlowName;
        speedSlow.fontName = GameScene.FUTURA_MEDIUM_FONT;
        speedSlow.color=SKColor.white;
        addChild(speedSlow);

        speedNormal.fontSize=30;
        speedNormal.name=speedNormalName;
        speedNormal.fontName = GameScene.FUTURA_MEDIUM_FONT;
        speedNormal.color=SKColor.white;
        addChild(speedNormal);
        
        speedFast.fontSize=30;
        speedFast.name=speedFastName;
        speedFast.fontName = GameScene.FUTURA_MEDIUM_FONT;
        speedFast.color=SKColor.white;
        addChild(speedFast);
        
        difficultyEasy.fontSize=30;
        difficultyEasy.name=difficultyEasyName;
        difficultyEasy.fontName = GameScene.FUTURA_MEDIUM_FONT;
        difficultyEasy.color=SKColor.white;
        addChild(difficultyEasy);
        
        difficultyNormal.fontSize=30;
        difficultyNormal.name=difficultyNormalName;
        difficultyNormal.color=SKColor.white;
        difficultyNormal.fontName = GameScene.FUTURA_MEDIUM_FONT;
        addChild(difficultyNormal);
        
        difficultyHard.fontSize=30;
        difficultyHard.name=difficultyHardName;
        difficultyHard.fontName = GameScene.FUTURA_MEDIUM_FONT;
        difficultyHard.color=SKColor.white;
        addChild(difficultyHard);
        
        self.addChild(soundImage);
        
        trueImage.name = trueImageName;
        self.addChild(trueImage);
        
        falseImage.name =  falseImageName;
        self.addChild(falseImage);
        
        back.name = backName;
        self.addChild(back);
        
        setDifficulty(value: Int16(UserDefaults.standard.integer(forKey: GameScene.DIFFICULTY_VALUE_KEY)));
        setBallSpeed(value: Int16(UserDefaults.standard.integer(forKey: GameScene.BALL_SPEED_VALUE_KEY)));
        setSoundEnabled(enabled: UserDefaults.standard.bool(forKey: GameScene.SOUND_VALUE_KEY));
    }
    
    func showSoundDialog(show:Bool){
        showSoundDialog = show;
    }
    
    override func didMove(to view: SKView){
        tittle.position = CGPoint(x: self.frame.midX,y: self.size.height*(1.5));
        onePlayer.position = CGPoint(x: size.height * 15/16,y: size.height * 2/4 + 40);
        twoPlayer.position = CGPoint(x: -size.height * 1/2,y: size.height * 2/4 - 40);
        settings.position = CGPoint(x: size.width/2, y: -50);
        difficulty.position=CGPoint(x: -self.size.width/2, y: self.size.height*12/16);
        ballSpeed.position=CGPoint(x: -self.size.width/2, y: self.size.height*8/16);
        sound.position=CGPoint(x: -self.size.width/2, y: self.size.height*5/16);
        soundOn.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        soundOff.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        speedSlow.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        speedNormal.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        speedFast.position=CGPoint(x: self.size.width*0.7, y: -self.size.height*0.5);
        difficultyEasy.position=CGPoint(x: self.size.width*0.7, y: self.size.height*1.5);
        difficultyNormal.position=CGPoint(x: self.size.width*0.7, y: self.size.height*1.5);
        difficultyHard.position=CGPoint(x: self.size.width*0.7, y: self.size.height*1.5);
        soundImage.position = CGPoint(x: self.size.width/2, y: self.size.height*1.5);
        trueImage.position = CGPoint(x: self.size.width*(-0.5), y: self.size.height*(0.05));
        falseImage.position = CGPoint(x: self.size.width*(1.5), y: self.size.height*(0.05));
        back.position = CGPoint(x: size.height * 15/16, y: (size.width * 1/16 + 30));
        if(showSoundDialog)
        {
            soundImage.run(SKAction.moveTo(y: size.height/2, duration: 2.0));
            trueImage.run(SKAction.moveTo(x: size.width*(0.1), duration: 2.0));
            falseImage.run(SKAction.moveTo(x: size.width*(0.9), duration: 2.0));
        }
        else
        {
            tittle.run(SKAction.moveTo(y: (self.size.height * 7/8), duration:2.0));
            onePlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            twoPlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            back.run(SKAction.moveTo(x: self.size.height * 15/16, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            difficulty.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            ballSpeed.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            sound.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            soundOn.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            soundOff.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            speedSlow.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            speedFast.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            speedNormal.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            difficultyEasy.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            difficultyHard.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            difficultyNormal.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first;
        let location = touch?.location(in: self);
        let node = self.atPoint(location!);
        
        switch (node.name) {
        case backName:
            tittle.run(SKAction.moveTo(y: (self.size.height * 7/8), duration:2.0));
            onePlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            twoPlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            back.run(SKAction.moveTo(x: self.size.height * 15/16, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            difficulty.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            ballSpeed.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            sound.run(SKAction.moveTo(x: -self.size.width/2, duration: 2.0));
            soundOn.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            soundOff.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            speedSlow.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            speedFast.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            speedNormal.run(SKAction.moveTo(y: -self.size.height*1/2, duration: 2.0));
            difficultyEasy.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            difficultyHard.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            difficultyNormal.run(SKAction.moveTo(y: self.size.height*1.5, duration: 2.0));
            break;
        case trueImageName:
            setSoundEnabled(enabled: true)
            tittle.run(SKAction.moveTo(y: size.height*0.9, duration: 2.0))
            onePlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            twoPlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            soundImage.run(SKAction.moveTo(y: size.height*1.5, duration: 2.0));
            trueImage.run(SKAction.moveTo(x: self.size.width*(-0.5), duration: 2.0));
            falseImage.run(SKAction.moveTo(x: self.size.width*(1.5), duration: 2.0));
            break;
        case falseImageName:
            setSoundEnabled(enabled: false)
            tittle.run(SKAction.moveTo(y: size.height*0.9, duration: 2.0))
            onePlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            twoPlayer.run(SKAction.moveTo(x: size.width/2, duration: 2.0));
            settings.run(SKAction.moveTo(y: size.height*0.3, duration: 2.0));
            soundImage.run(SKAction.moveTo(y: size.height*1.5, duration: 2.0));
            trueImage.run(SKAction.moveTo(x: self.size.width*(-0.5), duration: 2.0));
            falseImage.run(SKAction.moveTo(x: self.size.width*(1.5), duration: 2.0));
            break;
        case onePlayerName:
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 1)
            let game = Pong(size: self.size, muilplayer: false);
            self.view?.presentScene(game, transition: reveal)
            break;
        case twoPlayerName:
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 1);
            let game = Pong(size: self.size, muilplayer: true);
            self.view?.presentScene(game, transition: reveal);
            break;
        case settingsName:
            tittle.run(SKAction.moveTo(y: (self.size.height * 1.5), duration:2.0));
            onePlayer.run(SKAction.moveTo(x: self.size.height * 15/16, duration: 2.0));
            twoPlayer.run(SKAction.moveTo(x: -self.size.height * 15/16, duration: 2.0));
            settings.run(SKAction.moveTo(y: self.size.height * 7.2/8, duration: 2.0));
            back.run(SKAction.moveTo(x: size.height * 1/16, duration: 2.0));
            difficulty.run(SKAction.moveTo(x: self.size.width*0.25, duration: 2.0));
            ballSpeed.run(SKAction.moveTo(x: self.size.width*0.25, duration: 2.0));
            sound.run(SKAction.moveTo(x: self.size.width*0.25, duration: 2.0));
            soundOn.run(SKAction.moveTo(y: self.size.height*5.5/16, duration: 2.0));
            soundOff.run(SKAction.moveTo(y: self.size.height*4.5/16, duration: 2.0));
            speedSlow.run(SKAction.moveTo(y: self.size.height*9/16, duration: 2.0));
            speedFast.run(SKAction.moveTo(y: self.size.height*7/16, duration: 2.0));
            speedNormal.run(SKAction.moveTo(y: self.size.height*8/16, duration: 2.0));
            difficultyEasy.run(SKAction.moveTo(y: self.size.height*13/16, duration: 2.0));
            difficultyHard.run(SKAction.moveTo(y: self.size.height*11/16, duration: 2.0));
            difficultyNormal.run(SKAction.moveTo(y: self.size.height*12/16, duration: 2.0));
            break;
        case soundOnName:
             setSoundEnabled(enabled: true)
             break;
        case soundOffName:
            setSoundEnabled(enabled: false)
            break;
        case speedSlowName:
            setBallSpeed(value: -1)
            break;
        case speedNormalName:
            setBallSpeed(value: 0)
            break;
        case speedFastName:
        setBallSpeed(value: 1)
            break;
        case difficultyEasyName:
             setDifficulty(value: -1)
             break;
        case difficultyNormalName:
            setDifficulty(value: 0)
            break;
        case difficultyHardName:
            setDifficulty(value: 1)
            break;
        default:
            break;
        }
    }
    
    func setSoundEnabled(enabled:Bool!){
        soundEnabled = enabled;
        UserDefaults.standard.set(soundEnabled, forKey: GameScene.SOUND_VALUE_KEY);
        soundOn.fontColor = enabled ? SKColor.red : SKColor.white;
        soundOff.fontColor = enabled ? SKColor.white : SKColor.red;
    }
    
    func setDifficulty(value:Int16){
        difficultyValue = value;
        UserDefaults.standard.set(difficultyValue, forKey: GameScene.DIFFICULTY_VALUE_KEY);
        switch difficultyValue {
        case -1:
            difficultyEasy.fontColor=SKColor.red;
            difficultyNormal.fontColor=SKColor.white;
            difficultyHard.fontColor=SKColor.white;
            break;
        case 0:
            difficultyEasy.fontColor=SKColor.white;
            difficultyNormal.fontColor=SKColor.red;
            difficultyHard.fontColor=SKColor.white;
            break;
        case 1:
            difficultyEasy.fontColor=SKColor.white;
            difficultyNormal.fontColor=SKColor.white;
            difficultyHard.fontColor=SKColor.red;
            break;
        default:
            break;
        }
    }
    
    func setBallSpeed(value:Int16){
        ballSpeedValue = value;
        UserDefaults.standard.set(ballSpeedValue, forKey: GameScene.BALL_SPEED_VALUE_KEY);
        switch ballSpeedValue {
        case -1:
            speedSlow.fontColor=SKColor.red;
            speedNormal.fontColor=SKColor.white;
            speedFast.fontColor=SKColor.white;
            break;
        case 0:
            speedSlow.fontColor=SKColor.white;
            speedNormal.fontColor=SKColor.red;
            speedFast.fontColor=SKColor.white;
            break;
        case 1:
            speedSlow.fontColor=SKColor.white;
            speedNormal.fontColor=SKColor.white;
            speedFast.fontColor=SKColor.red;
            break;
        default:
            break;
        }
    }
}

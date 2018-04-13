//
//  Pong.swift
//  Pong
//
//  Created by Artyom Dangizyan on 12/13/14.
//  Copyright (c) 2014 Artyom Dangizyan. All rights reserved.
//


import SpriteKit


class Pong: SKScene, SKPhysicsContactDelegate {
    
    class Player {
        let paddle:SKSpriteNode;
        var scoreValue:Int = 0;
        let score:SKLabelNode;
        init(){
            paddle=SKSpriteNode(imageNamed:"paddle");
            score  = SKLabelNode(text: String(scoreValue))
        }
        func updateScore(){
            score.text = String(scoreValue)
        }
    }
    
    let ballCategory:UInt32   = 1;
    let paddleCategory:UInt32 = 2;
    let edgeCategory:UInt32   = 4;
    let bottomEdgeCategory:UInt32 = 8;
    let upEdgeCategory:UInt32 = 16;
    
    var ballNode = SKSpriteNode(imageNamed:"ball");
    let pauseNode = SKSpriteNode(imageNamed: "pause");
    let continueNode = SKSpriteNode(imageNamed: "continue");
    let restartNode = SKSpriteNode(imageNamed: "reload");
    let homeNode = SKSpriteNode(imageNamed: "home");
    let pauseLabel = SKLabelNode(fontNamed:  "PAUSE")
    
    var player = Player();
    var oponent = Player();
    
    var muiltyplayer:Bool!;
    var difficultyValue:Int16;
    var ballSpeedValue:Int16;
    var soundEnabled:Bool;
    
    required init?(coder aDecoder: NSCoder) {
        difficultyValue = Int16(UserDefaults.standard.integer(forKey: GameScene.DIFFICULTY_VALUE_KEY));
        ballSpeedValue = Int16(UserDefaults.standard.integer(forKey: GameScene.BALL_SPEED_VALUE_KEY))+2;
        soundEnabled = UserDefaults.standard.bool(forKey: GameScene.SOUND_VALUE_KEY);
        muiltyplayer=false;
        super.init(coder: aDecoder);
    }
    
    init(size: CGSize,muilplayer: Bool) {
        difficultyValue = Int16(UserDefaults.standard.integer(forKey: GameScene.DIFFICULTY_VALUE_KEY));
        ballSpeedValue = Int16(UserDefaults.standard.integer(forKey: GameScene.BALL_SPEED_VALUE_KEY))+2;
        soundEnabled = UserDefaults.standard.bool(forKey: GameScene.SOUND_VALUE_KEY);
        muiltyplayer=muilplayer;
        super.init(size: size);
    }
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black;
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = edgeCategory;
        physicsWorld.gravity = CGVector(dx: 0, dy: 0);
        addPlayer();
        addedges();
        _ = SKAction.playSoundFileNamed("blip.caf", waitForCompletion:false);
        addPause();
        addOponent();
        initPauseMenu();
        addBall();
    }
    
    func addBall(){
        ballNode.position=CGPoint(x: size.width/2, y: size.height/2)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNode.frame.size.width/2)
        ballNode.physicsBody?.friction = 0;
        ballNode.physicsBody?.linearDamping = 0;
        ballNode.physicsBody?.restitution = 1.0;
        ballNode.physicsBody?.categoryBitMask = ballCategory;
        ballNode.physicsBody?.contactTestBitMask =  paddleCategory | bottomEdgeCategory | upEdgeCategory;
        self.addChild(ballNode);
        let speed = Double(ballSpeedValue*10);
        let angle = Double(arc4random_uniform(90)+45)*Double.pi / 180;
        ballNode.physicsBody?.applyImpulse(CGVector(dx:speed*cos(angle), dy:speed*sin(angle)));
    }
    
    func addPlayer(){
        player.paddle.position = CGPoint(x: size.width/2,y: size.height*0.1);
        player.paddle.physicsBody =  SKPhysicsBody(rectangleOf: player.paddle.frame.size);
        player.paddle.physicsBody?.isDynamic = false;
        player.paddle.physicsBody?.categoryBitMask = paddleCategory;
        player.score.position = CGPoint(x: size.width/4, y: (size.height*0.4));
        self.addChild(player.paddle);
        self.addChild(player.score);
    }
    
    func addedges(){
        let bottomEdge = SKNode();
        bottomEdge.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 0), to: CGPoint(x: size.width, y: 0));
        bottomEdge.physicsBody?.categoryBitMask = bottomEdgeCategory;
        let upEdge = SKNode();
        upEdge.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: size.height), to: CGPoint(x: size.width, y: size.height));
        upEdge.physicsBody?.categoryBitMask = upEdgeCategory;
        self.addChild(upEdge);
        self.addChild(bottomEdge);
    }
    func addOponent(){
        oponent.paddle.position = CGPoint(x: size.width/2,y: size.height*0.9);
        oponent.paddle.physicsBody =  SKPhysicsBody(rectangleOf: oponent.paddle.frame.size);
        oponent.paddle.physicsBody?.isDynamic = false;
        oponent.paddle.physicsBody?.categoryBitMask = paddleCategory;
        oponent.score.position = CGPoint(x: size.width/4, y: (size.height*0.55));
        self.addChild(oponent.paddle);
        if((muiltyplayer) != nil && muiltyplayer==true){
            oponent.score.position = CGPoint(x: size.width/4, y: (size.height*0.6));
            oponent.score.zRotation=atan2(0, -200)
        }
        
        self.addChild(oponent.score);
    }
    
    func addPause()
    {
        pauseNode.position = CGPoint(x: size.width/4, y: (size.height/2));
        pauseNode.name="pause";
        self.addChild(pauseNode);
        
    }
    
    func initPauseMenu()
    {
        continueNode.position = CGPoint(x: -size.width/2,y: size.height/2);
        restartNode.position = CGPoint(x: size.width/2, y: size.height*1.5);
        homeNode.position = CGPoint(x: size.width*1.5,y: size.height/2);
        continueNode.name="continue";
        homeNode.name="home";
        pauseLabel.text="PAUSE"
        pauseLabel.fontColor=SKColor.white;
        pauseLabel.fontSize=50;
        pauseLabel.fontName = GameScene.FUTURA_MEDIUM_FONT;
        pauseLabel.position=CGPoint(x: self.size.width/2, y: self.size.height*1.5);
        restartNode.name="restart";
        self.addChild(restartNode);
        self.addChild(pauseLabel);
        self.addChild(homeNode);
        self.addChild(continueNode);
        
    }
    
    func addPauseMenu()
    {
        pauseNode.removeFromParent();
        pauseLabel.run(SKAction.moveTo(y: self.size.height*0.7, duration: 0.1));
        let wait = SKAction.wait(forDuration: 0.2)
        let pause = SKAction.run {self.isPaused = true;}
        let sequence = SKAction.sequence([wait, pause])
        let homeNodeAction:[SKAction] = [SKAction.moveTo(x: size.width*0.7, duration: 0.2)];
        let group = SKAction.group(homeNodeAction + [sequence])
        continueNode.run(SKAction.moveTo(x: size.width*0.3, duration: 0.2));
        restartNode.run(SKAction.moveTo(y: size.height/2, duration: 0.2));
        homeNode.run(group);
    }
    
    func remouvePauseMenu()
    {
        pauseLabel.run(SKAction.moveTo(y: self.size.height*1.5, duration: 0.5));
        continueNode.run(SKAction.moveTo(x: -size.width/2, duration: 0.5));
        restartNode.run(SKAction.moveTo(y: size.height*1.5, duration: 0.5));
        homeNode.run(SKAction.moveTo(x: size.width*1.5, duration: 0.5));
        self.isPaused = false;
        addChild(pauseNode);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self);
            let node = self.atPoint(location);
            if(node.name=="pause")
            {
                if(!isPaused){
                    addPauseMenu();}
                else{
                    self.isPaused=false;
                }
            }
            if(node.name=="continue")
            {
                remouvePauseMenu();
            }
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
            if(node.name=="restart")
            {
                let game = Pong(size: self.size, muilplayer: muiltyplayer);
                self.view?.presentScene(game, transition: reveal)
            }
            if(node.name=="home")
            {
                let menu = GameScene(size: self.size);
                menu.showSoundDialog(show: false)
                self.view?.presentScene(menu, transition: reveal)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var notTheBall:SKPhysicsBody;
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            notTheBall = contact.bodyB;
        } else {
            notTheBall = contact.bodyA;
        }
        
        if (notTheBall.categoryBitMask == paddleCategory) {
            if(soundEnabled){
                let playSFX = SKAction.playSoundFileNamed("blip.caf", waitForCompletion:false);
                self.run(playSFX);
            }
        }
        if (notTheBall.categoryBitMask == upEdgeCategory || notTheBall.categoryBitMask == bottomEdgeCategory) {
            let playerWon = notTheBall.categoryBitMask == upEdgeCategory;
            if(soundEnabled){
                let playSFX:SKAction;
                if(playerWon){
                    playSFX = SKAction.playSoundFileNamed("win.caf", waitForCompletion:false);
                }else{
                    playSFX = SKAction.playSoundFileNamed("lose.caf", waitForCompletion:false);
                }
                self.run(playSFX);
            }
            
            let winner:Player = playerWon ? player:oponent;
            if(winner.scoreValue >= 20){
                var finalText:String;
                if(!muiltyplayer && playerWon){
                    finalText = "You Won";
                }else if(!muiltyplayer && !playerWon){
                    finalText = "GAME OVER";
                }else if(muiltyplayer && playerWon){
                    finalText = "Player 1 Won";
                }else {
                    finalText = "Player 2 Won";
                }
                let end = End(size: self.size, finalText: finalText, muiltyplayer: muiltyplayer);
                let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                self.view?.presentScene(end, transition: reveal);
            }else{
                winner.scoreValue += 1;
                winner.updateScore()
                moveBallToCenter(directionChoose: playerWon);
            }
        }
    }
    
    func moveBallToCenter(directionChoose:Bool){
        ballNode.isHidden=true;
        let moveBall = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2), duration: 0)
        ballNode.run(moveBall)
        ballNode.isHidden=false;
        ballNode.physicsBody = nil;
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNode.frame.size.width/2)
        ballNode.physicsBody?.friction = 0;
        ballNode.physicsBody?.linearDamping = 0;
        ballNode.physicsBody?.restitution = 1.0;
        ballNode.physicsBody?.categoryBitMask = ballCategory;
        ballNode.physicsBody?.contactTestBitMask =  paddleCategory | bottomEdgeCategory | upEdgeCategory;
        let speed = Double(ballSpeedValue*10);
        let angle = Double(arc4random_uniform(90)+45) * Double.pi / 180;
        let direction:Double = directionChoose ? (1) : (-1);
        ballNode.physicsBody?.applyImpulse(CGVector(dx:speed*cos(angle), dy:speed*sin(angle)*direction));
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(self.muiltyplayer){
            return;
        }
        
        if (ballNode.position.x > oponent.paddle.size.width/2 && ballNode.position.x < self.size.width-oponent.paddle.size.width/2) {
            var duration:Double = 0.15;
            
            if(difficultyValue == -1)
            {
                duration = 0.25;
            }
            else if(difficultyValue==0)
            {
                duration = 0.15;
            }
            else  if(difficultyValue==1)
            {
                duration = 0.05;
            }
            let moveLabel = SKAction.moveTo(x: ballNode.position.x, duration: duration)
            oponent.paddle.run(moveLabel)
        }
        
        if(ballNode.position.x<0||ballNode.position.y>self.size.height||ballNode.position.y<0||ballNode.position.x>self.size.width){
            moveBallToCenter(directionChoose: true);
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isPaused){
            return;
        }
        for touch in touches
        {
            let location = touch.location(in: self)
            if(location.y < self.size.height*0.3)
            {
                var newPosition = CGPoint(x: location.x, y: self.player.paddle.position.y);
                if (newPosition.x < player.paddle.size.width / 2) {
                    newPosition.x = player.paddle.size.width / 2;
                    
                }
                else if (newPosition.x > self.size.width - (player.paddle.size.width/2)) {
                    newPosition.x = self.size.width - (player.paddle.size.width/2);
                    
                }
                player.paddle.position = newPosition;
            }
            else if(location.y > self.size.height*0.7 && (muiltyplayer) != nil && muiltyplayer == true ){
                
                var newPosition = CGPoint(x: location.x, y: self.oponent.paddle.position.y);
                if (newPosition.x < self.oponent.paddle.size.width / 2) {
                    newPosition.x = self.oponent.paddle.size.width / 2;
                    
                }
                else if (newPosition.x > self.size.width - (self.oponent.paddle.size.width/2)) {
                    newPosition.x = self.size.width - (self.oponent.paddle.size.width/2);
                }
                self.oponent.paddle.position = newPosition;
            }
        }
    }
}

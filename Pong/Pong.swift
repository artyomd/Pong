//
//  Pong.swift
//  Pong
//
//  Created by Artyom Dangizyan on 12/13/14.
//  Copyright (c) 2014 Artyom Dangizyan. All rights reserved.
//


import SpriteKit


class Pong: SKScene, SKPhysicsContactDelegate {
    
    let ballCategory:UInt32   = 1;
    let paddleCategory:UInt32 = 2;
    let edgeCategory:UInt32   = 4;
    let bottomEdgeCategory:UInt32 = 8;
    let upEdgeCategory:UInt32 = 16;
    var muiltyplayer:Bool!;
    let ball = SKSpriteNode(imageNamed:"ball");
    var SP = false;
    var BP = false;
    var KP = false;
    var p = player();
    var o = player();
    let pause = SKSpriteNode(imageNamed: "pause");
    let Continue = SKSpriteNode(imageNamed: "continue");
    let restart = SKSpriteNode(imageNamed: "reload");
    let home = SKSpriteNode(imageNamed: "home");
    let lpause = SKLabelNode(fontNamed:  "Futura Medium")
    var vspeed:Int16;
    var vdif:Int16;
    var vsound:Bool;
    struct player {
        let paddle:SKSpriteNode;
        var value:Int;
        let score:SKLabelNode;
        init(){
            paddle=SKSpriteNode(imageNamed:"paddle");
            value=0;
            score  = SKLabelNode(text: String(value) );
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(size: CGSize,muilplayer: Bool,difficluty: Int16,speed: Int16,sound: Bool) {
        vspeed=speed;
        vdif=difficluty;
        vsound=sound;
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
        ball.position=CGPoint(x: size.width/2, y: size.height/2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
        ball.physicsBody?.friction = 0;
        ball.physicsBody?.linearDamping = 0;
        ball.physicsBody?.restitution = 1.0;
        ball.physicsBody?.categoryBitMask = ballCategory;
        ball.physicsBody?.contactTestBitMask =  paddleCategory | bottomEdgeCategory | upEdgeCategory;
        self.addChild(ball);
        if(vspeed==2)
        {
            let x:CGFloat = (CGFloat(UInt(arc4random_uniform(8))) + 6)*(1);
            let y:CGFloat = (CGFloat(UInt(arc4random_uniform(8))) + 6)*(1);
            ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
        }
        else if(vspeed==3)
        {
            let x:CGFloat = (CGFloat(UInt(arc4random_uniform(14))) + 6)*(1);
            let y:CGFloat = (CGFloat(UInt(arc4random_uniform(14))) + 6)*(1);
            ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
        }
        else if(vspeed==1)
        {
            let x:CGFloat = (CGFloat(UInt(arc4random_uniform(5))) + 5)*(1);
            let y:CGFloat = (CGFloat(UInt(arc4random_uniform(5))) + 5)*(1);
            ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
        }
        
    }
    func addPlayer(){
        p.paddle.position = CGPoint(x: size.width/2,y: size.height*0.1);
        p.paddle.physicsBody =  SKPhysicsBody(rectangleOf: p.paddle.frame.size);
        p.paddle.physicsBody?.isDynamic = false;
        p.paddle.physicsBody?.categoryBitMask = paddleCategory;
        p.score.position = CGPoint(x: size.width/4, y: (size.height*0.4));
        self.addChild(p.paddle);
        self.addChild(p.score);
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
        o.paddle.position = CGPoint(x: size.width/2,y: size.height*0.9);
        o.paddle.physicsBody =  SKPhysicsBody(rectangleOf: p.paddle.frame.size);
        o.paddle.physicsBody?.isDynamic = false;
        o.paddle.physicsBody?.categoryBitMask = paddleCategory;
        o.score.position = CGPoint(x: size.width/4, y: (size.height*0.55));
        self.addChild(o.paddle);
        if((muiltyplayer) != nil && muiltyplayer==true){
             o.score.position = CGPoint(x: size.width/4, y: (size.height*0.6));
                o.score.zRotation=atan2(0, -200)
        }
        
        self.addChild(o.score);
    }
    
    func addPause()
    {
        pause.position = CGPoint(x: size.width/4, y: (size.height/2));
        pause.name="pause";
        self.addChild(pause);
    
    }
    func initPauseMenu()
    {
        Continue.position = CGPoint(x: -size.width/2,y: size.height/2);
        restart.position = CGPoint(x: size.width/2, y: size.height*1.5);
        home.position = CGPoint(x: size.width*1.5,y: size.height/2);
        Continue.name="continue";
        home.name="home";
        lpause.text="PAUSE"
        lpause.fontColor=SKColor.white;
        lpause.fontSize=50;
        lpause.position=CGPoint(x: self.size.width/2, y: self.size.height*1.5);
        restart.name="restart";
        self.addChild(restart);
        self.addChild(lpause);
        self.addChild(home);
        self.addChild(Continue);

    }
    func addPauseMenu()
    {
        pause.removeFromParent();
        lpause.run(SKAction.moveTo(y: self.size.height*0.7, duration: 0.1));
        Continue.run(SKAction.moveTo(x: size.width*0.3, duration: 0.2),completion: {self.KP = true});
        restart.run(SKAction.moveTo(y: size.height/2, duration: 0.2), completion: {self.BP = true;});
        home.run(SKAction.moveTo(x: size.width*0.7, duration: 0.2), completion: {self.SP = true;});

    }
    func remouvePauseMenu()
    {
        
        self.KP = false;
        self.BP = false;
        self.SP = false;
        lpause.run(SKAction.moveTo(y: self.size.height*1.5, duration: 0.5));
        Continue.run(SKAction.moveTo(x: -size.width/2, duration: 0.5));
        restart.run(SKAction.moveTo(y: size.height*1.5, duration: 0.5));
        home.run(SKAction.moveTo(x: size.width*1.5, duration: 0.5));
        self.isPaused = false;
        addChild(pause);
      

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
            if(node.name=="restart")
            {
                let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let game = Pong(size: self.size, muilplayer: muiltyplayer, difficluty: vdif, speed: vspeed, sound: vsound);
                self.view?.presentScene(game, transition: reveal)

            }
            if(node.name=="home")
            {
                let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let menu = GameScene(size: self.size);
                menu.addSettings( vdif, speed: vspeed, sound: vsound, start: true)
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
            if(vsound){
            let playSFX = SKAction.playSoundFileNamed("blip.caf", waitForCompletion:false);
            self.run(playSFX);
            }
        }
        if (notTheBall.categoryBitMask == upEdgeCategory) {
            if(vsound){
            let playSFX = SKAction.playSoundFileNamed("app_game_interactive_alert_tone_026.mp3", waitForCompletion:false);
            self.run(playSFX);
            }
            if(p.value == 20)
            {
                let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                if((muiltyplayer) != nil && muiltyplayer == false){
                let end = End(size: self.size, ltext: "You Won", muiltyplayer: false, difficluty: vdif, speed: vspeed, sound: vsound);
                    self.view?.presentScene(end, transition: reveal);
                }
                else
                {
                    let end = End(size: self.size, ltext: "1 Player Won", muiltyplayer: true, difficluty: vdif, speed: vspeed, sound: vsound);
                    self.view?.presentScene(end, transition: reveal);
                }
                

            }
            else
            {
                p.value += 1;
                ball.isHidden=true;
                let moveBall = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2), duration: 0)
                ball.run(moveBall)
                ball.isHidden=false;
                ball.physicsBody = nil;
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
                ball.physicsBody?.friction = 0;
                ball.physicsBody?.linearDamping = 0;
                ball.physicsBody?.restitution = 1.0;
                ball.physicsBody?.categoryBitMask = ballCategory;
                ball.physicsBody?.contactTestBitMask =  paddleCategory | bottomEdgeCategory | upEdgeCategory;
                if(vspeed==2)
                {
                    let x:CGFloat = (CGFloat(UInt(arc4random_uniform(8))) + 6)*(1);
                    let y:CGFloat = (CGFloat(UInt(arc4random_uniform(8))) + 6)*(1);
                    ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
                }
                else if(vspeed==3)
                {
                    let x:CGFloat = (CGFloat(UInt(arc4random_uniform(14))) + 6)*(1);
                    let y:CGFloat = (CGFloat(UInt(arc4random_uniform(14))) + 6)*(1);
                    ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
                }
                else if(vspeed==1)
                {
                    let x:CGFloat = (CGFloat(UInt(arc4random_uniform(5))) + 5)*(1);
                    let y:CGFloat = (CGFloat(UInt(arc4random_uniform(5))) + 5)*(1);
                    ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
                }
            }
        }
        
        if (notTheBall.categoryBitMask == bottomEdgeCategory) {
            if(vsound)
            {
            let playSFX = SKAction.playSoundFileNamed("synth_stab.mp3", waitForCompletion:false);
            self.run(playSFX);
            }
            if(o.value==20)
            {
                let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                if((muiltyplayer) != nil && muiltyplayer == false){
                    let end = End(size: self.size, ltext: "GAME OVER", muiltyplayer: false, difficluty: vdif, speed: vspeed, sound: vsound);
                    self.view?.presentScene(end, transition: reveal);
                }
                else
                {
                    let end = End(size: self.size, ltext: "2 Player Won", muiltyplayer: true, difficluty: vdif, speed: vspeed, sound: vsound);
                    self.view?.presentScene(end, transition: reveal);
                }
            }
            else
            {
                o.value += 1;
                ball.isHidden=true;
                let moveBall = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2), duration: 0)
                ball.run(moveBall)
                ball.isHidden=false;
                ball.physicsBody = nil;
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
                ball.physicsBody?.friction = 0;
                ball.physicsBody?.linearDamping = 0;
                ball.physicsBody?.restitution = 1.0;
                ball.physicsBody?.categoryBitMask = ballCategory;
                ball.physicsBody?.contactTestBitMask =  paddleCategory | bottomEdgeCategory | upEdgeCategory;
                if(vspeed==2)
                {
                    let x:CGFloat = (CGFloat(UInt(arc4random_uniform(8))) + 6)*(1);
                    let y:CGFloat = (CGFloat(UInt(arc4random_uniform(8))) + 6)*(-1);
                    ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
                }
                else if(vspeed==3)
                {
                    let x:CGFloat = (CGFloat(UInt(arc4random_uniform(14))) + 6)*(1);
                    let y:CGFloat = (CGFloat(UInt(arc4random_uniform(14))) + 6)*(-1);
                    ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
                }
                else if(vspeed==1)
                {
                    let x:CGFloat = (CGFloat(UInt(arc4random_uniform(5))) + 5)*(1);
                    let y:CGFloat = (CGFloat(UInt(arc4random_uniform(5))) + 5)*(-1);
                    ball.physicsBody?.applyImpulse( CGVector(dx: randomPlusMinus(x) , dy: y));
                }

            }
        }
        
    }
    override func update(_ currentTime: TimeInterval) {
        if(!muiltyplayer){
            
            if (ball.position.x > 10 && ball.position.x < self.size.width-10) {
                
                if(vdif==2)
                {
                let moveLabel = SKAction.moveTo(x: ball.position.x, duration: 0.15)
                o.paddle.run(moveLabel)
                }
                else  if(vdif==1)
                {
                    let moveLabel = SKAction.moveTo(x: ball.position.x, duration: 0.23)
                    o.paddle.run(moveLabel)
                }
                else  if(vdif==3)
                {
                    let moveLabel = SKAction.moveTo(x: ball.position.x, duration: 0.05)
                    o.paddle.run(moveLabel)
                }
            }
            if(o.paddle.position.x == 60 || o.paddle.position.x < 60)
            {
                o.paddle.position.x+=1;
            }
            if(o.paddle.position.x == (self.size.width - 60) || (o.paddle.position.x > self.size.width - 60))
            {
            o.paddle.position.x -= 1;
            }
            
        }
        if(self.SP == true && self.KP==true && self.BP == true)
        {
            self.isPaused=true;
        }
        else
        {
            self.isPaused = false;
        }
        
        p.score.text = String(p.value);
        o.score.text = String(o.value);
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches
        {
            
            //let location = (touches.first as? UITouch)?.locationInNode(self)
            let location = touches.first?.location(in: self)
            
            if(!isPaused){
                if(location!.y < self.size.height*0.3)
                {
                    var newPosition = CGPoint(x: location!.x, y: self.p.paddle.position.y);
                    if (newPosition.x < p.paddle.size.width / 2) {
                        newPosition.x = p.paddle.size.width / 2;
                    
                    }
                    if (newPosition.x > self.size.width - (p.paddle.size.width/2)) {
                        newPosition.x = self.size.width - (p.paddle.size.width/2);
                    
                    }
                    p.paddle.position = newPosition;
                }
                if((muiltyplayer) != nil && muiltyplayer == true){
                    if (location!.y > self.size.height*0.7) {
                    
                    
                        var newPosition = CGPoint(x: location!.x, y: self.o.paddle.position.y);
                        if (newPosition.x < self.o.paddle.size.width / 2) {
                            newPosition.x = self.o.paddle.size.width / 2;
                        
                        }
                        if (newPosition.x > self.size.width - (self.o.paddle.size.width/2)) {
                            newPosition.x = self.size.width - (self.o.paddle.size.width/2);
                        
                        }
                        self.o.paddle.position = newPosition;
                    }
                }
            }
        }
    }
    
    func randomPlusMinus(_ value:CGFloat) -> CGFloat {
        let invert: Bool = arc4random_uniform(2) == 1
        return value * (invert ? -1.0 : 1.0)
    }
}

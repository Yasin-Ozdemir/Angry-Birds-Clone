//
//  GameScene.swift
//  Angry Birds Clone
//
//  Created by Yasin Özdemir on 24.03.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var box6 = SKSpriteNode()
    var firstPosition : CGPoint?
    var box1Position = CGPoint()
    var box2Position = CGPoint()
    var box3Position = CGPoint()
    var box4Position = CGPoint()
    var box5Position = CGPoint()
    var box6Position = CGPoint()
    
    var Continue = 3
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    
    enum ColliderType : UInt32 {
        case bird = 1
        case box = 2
    }
    
    var gameStarted = false
    override func didMove(to view: SKView) {
        // scene
        self.scene?.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)  // tüm ekranı fiziksel bir dünya yaptık
        self.physicsWorld.contactDelegate = self // artık ekrandaki çarpışmaları algılıyabiliyoruz
        
        
        
        // bird
        var birdTextture = SKTexture(imageNamed: "bird")
        bird = childNode(withName: "bird") as! SKSpriteNode
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTextture.size().height / 14)  // fiziksel vücudunu tanımladık bu vücut kutuya çarpma , yer çekimi etkisine girme vs için gerekli
        
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.mass = 0.2
        firstPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        
        //LABEL
        
        scoreLabel.text = "0"
        scoreLabel.fontName = "Helvatica"
        scoreLabel.fontSize = 63
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4.2)
        scoreLabel.fontColor = .black
        self.addChild(scoreLabel)
        
        
        
        
        
        
        //BOX
        
        var boxTexture = SKTexture(imageNamed: "box")
        var size = CGSize(width: boxTexture.size().width / 6.75, height: boxTexture.size().height / 6.75)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.mass = 0.15
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true
        box1Position = box1.position
        
        box1.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.mass = 0.15
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.allowsRotation = true
        box2Position = box2.position
        
        box2.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.mass = 0.15
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true
        box3Position = box3.position
        
        box3.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.mass = 0.15
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true
        box4Position = box4.position
        
        box4.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.mass = 0.15
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true
        box5Position = box5.position
        
        box5.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box6 = childNode(withName: "box6") as! SKSpriteNode
        
        box6.physicsBody = SKPhysicsBody(rectangleOf: size)
        box6.physicsBody?.affectedByGravity = true
        box6.physicsBody?.mass = 0.15
        box6.physicsBody?.isDynamic = true
        box6.physicsBody?.allowsRotation = true
        box6Position = box6.position
        box6.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
}
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.box.rawValue{
            score = score + 1
            scoreLabel.text = String(score)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       // bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 400))
        // bird.physicsBody?.affectedByGravity = true
        
        
        if gameStarted == false && self.Continue > 0{
            if let touch = touches.first { // dokunma varsa
                
                let touchLocation = touch.location(in: self) // dokunulan noktadanın koordinatlarını touchLocation değişkenine verdik
                
                let touchNodes = nodes(at: touchLocation) // dokunulan noktadaki node'leri bir dizi şeklinde touchNodes değişkenine verdik
                
                if touchNodes.isEmpty != true{
                    for myNode in touchNodes {                         // dokunulan node'lerin içinden bird'i bulup hareket ettirdik
                        if myNode == self.bird{
                            self.bird.position = touchLocation
                        }
                    }
                }
                
                
            }
            
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false && self.Continue > 0{
            if let touch = touches.first { // dokunma varsa
                
                let touchLocation = touch.location(in: self) // dokunulan noktadanın koordinatlarını touchLocation değişkenine verdik
                
                let touchNodes = nodes(at: touchLocation) // dokunulan noktadaki node'leri bir dizi şeklinde touchNodes değişkenine verdik
                
                if touchNodes.isEmpty != true{
                    for myNode in touchNodes {                         // dokunulan node'lerin içinden bird'i bulup hareket ettirdik
                        if myNode == self.bird{
                            self.bird.position = touchLocation
                        }
                    }
                }
                
                
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false && self.Continue > 0{
            if let touch = touches.first { // dokunma varsa
                
                let touchLocation = touch.location(in: self) // dokunulan noktadanın koordinatlarını touchLocation değişkenine verdik
                
                let touchNodes = nodes(at: touchLocation) // dokunulan noktadaki node'leri bir dizi şeklinde touchNodes değişkenine verdik
                
                if touchNodes.isEmpty != true{
                    for myNode in touchNodes {                         // dokunulan node'lerin içinden bird'i bulup hareket ettirdik
                        if myNode == self.bird{
                            
                            
                            let dx = 2*(firstPosition!.x - touchLocation.x)
                            let dy = 2*(firstPosition!.y - touchLocation.y)
                            
                            self.bird.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
                            self.bird.physicsBody?.affectedByGravity = true
                            self.Continue = self.Continue - 1
                            self.gameStarted = true
                            
                            
                        }
                    }
                }
                
                
            }
        }
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if (bird.physicsBody?.velocity.dx)! <= 0.2 && (bird.physicsBody?.velocity.dy)! <= 0.2 && bird.physicsBody!.angularVelocity <= 0.1 && gameStarted == true{
            
            
            bird.physicsBody?.affectedByGravity = false
            bird.physicsBody?.velocity.dy = 0
            bird.physicsBody?.velocity.dx = 0
            bird.physicsBody?.angularVelocity = 0
            bird.position = firstPosition!
            
            box1.position = box1Position
            box2.position = box2Position
            box3.position = box3Position
            box4.position = box4Position
            box5.position = box5Position
            box6.position = box6Position
            
            gameStarted = false
            
            if self.Continue == 0{
                var alert = UIAlertController(title: "HOOPS!", message: "Chance Finished", preferredStyle: UIAlertController.Style.alert)
                var OKbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(OKbutton)
                scene?.view?.window?.rootViewController?.present(alert, animated: true)
                self.Continue = 3
                self.score = 0
                self.scoreLabel.text = String(self.score)
            }
        }
    }
    
    
    
}

//
//  GameScene.swift
//  BallFall
//
//  Created by Mykyta Kurochka on 23.06.2024.
//

import Foundation
import SpriteKit
import CoreMotion

protocol GameSceneDelegate: AnyObject {
    func gameOver(won: Bool)
    func updateTimer(timeRemaining: TimeInterval)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    // game vars
    weak var gameDelegate: GameSceneDelegate?
    var colors: [UIColor] = [UIColor.platformOneColor, UIColor.platformTwoColor]
    var ball: SKSpriteNode!
    var gameStarted = false
    var platforms = [SKSpriteNode]()
    var obstacles = [SKSpriteNode]()
    let motionManager = CMMotionManager()
    var timer: Timer?
    var timerTick: TimeInterval = 1
    var gameStartTime: TimeInterval = 0
    var lastPlatformY: CGFloat = 0
    var elapsedTime: TimeInterval = 0
    var timeRemaining: TimeInterval = 30
    // collision vars
    let ballCategory: UInt32 = 0x1 << 0
    let platformCategory: UInt32 = 0x1 << 1
    let boundaryCategory: UInt32 = 0x1 << 2
    let obstacleCategory: UInt32 = 0x1 << 3
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        
        setupBall()
        setupBoundaries()
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
    }
    
    func setupBall() {
        ball = SKSpriteNode(imageNamed: "ball")
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height)
        ball.isHidden = true
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = platformCategory | obstacleCategory
        ball.physicsBody?.collisionBitMask = platformCategory | boundaryCategory
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.restitution = 0.3 // Bounciness
        ball.physicsBody?.linearDamping = 0.5 // Slow down over time
        ball.physicsBody?.angularDamping = 0.8 // Slow down rotation over time
        addChild(ball)
    }
    
    func setupBoundaries() {
        let boundaryThickness: CGFloat = 10
        
        // Left boundary
        let leftBoundary = SKNode()
        leftBoundary.position = CGPoint(x: -boundaryThickness / 2, y: frame.midY)
        leftBoundary.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: boundaryThickness, height: frame.height))
        leftBoundary.physicsBody?.isDynamic = false
        leftBoundary.physicsBody?.categoryBitMask = boundaryCategory
        addChild(leftBoundary)
        
        // Right boundary
        let rightBoundary = SKNode()
        rightBoundary.position = CGPoint(x: frame.width + boundaryThickness / 2, y: frame.midY)
        rightBoundary.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: boundaryThickness, height: frame.height))
        rightBoundary.physicsBody?.isDynamic = false
        rightBoundary.physicsBody?.categoryBitMask = boundaryCategory
        addChild(rightBoundary)
        
        print("Left and right boundaries added.")
    }
    
    func startGame() {
        timeRemaining = 30
        gameDelegate?.updateTimer(timeRemaining: timeRemaining)
        gameStarted = true
        ball.isHidden = false
        ball.physicsBody?.affectedByGravity = true
        gameStartTime = CACurrentMediaTime()
        lastPlatformY = ball.position.y - 100 // Initial platform position
        
        createPlatform()
        
        // Start timer with initial timerTick value
        timer = Timer.scheduledTimer(withTimeInterval: timerTick, repeats: true, block: { _ in
            self.createPlatform()
            if self.timeRemaining == 0 {
                self.gameOver(won: false)
            } else {
                
                self.timeRemaining -= 1
                self.gameDelegate?.updateTimer(timeRemaining: self.timeRemaining)
            }
        })
        
        print("Game started. Ball is now visible and affected by gravity.")
    }
    
    @objc func createPlatform() {
        let platformWidth = frame.width
        let platformHeight: CGFloat = 20
        let holeWidth: CGFloat = 50
        let holePositionX = CGFloat.random(in: holeWidth / 2...(platformWidth - holeWidth / 2))
        let platformY = lastPlatformY - 150 // Ensure at least 150 points vertical space between platforms
        
        lastPlatformY = platformY
        
        // Left segment
        let leftWidth = holePositionX - (holeWidth / 2)
        if leftWidth > 0 {
            let leftPlatform = SKSpriteNode(color: colors.randomElement()!, size: CGSize(width: leftWidth, height: platformHeight))
            leftPlatform.position = CGPoint(x: leftWidth / 2, y: platformY)
            leftPlatform.physicsBody = SKPhysicsBody(rectangleOf: leftPlatform.size)
            leftPlatform.physicsBody?.isDynamic = false
            leftPlatform.physicsBody?.categoryBitMask = platformCategory
            leftPlatform.physicsBody?.contactTestBitMask = ballCategory
            leftPlatform.physicsBody?.collisionBitMask = ballCategory
            addChild(leftPlatform)
            platforms.append(leftPlatform)
        }
        
        // Right segment
        let rightWidth = platformWidth - (holePositionX + (holeWidth / 2))
        if rightWidth > 0 {
            let rightPlatform = SKSpriteNode(color: colors.randomElement()!, size: CGSize(width: rightWidth, height: platformHeight))
            rightPlatform.position = CGPoint(x: holePositionX + (holeWidth / 2) + (rightWidth / 2), y: platformY)
            rightPlatform.physicsBody = SKPhysicsBody(rectangleOf: rightPlatform.size)
            rightPlatform.physicsBody?.isDynamic = false
            rightPlatform.physicsBody?.categoryBitMask = platformCategory
            rightPlatform.physicsBody?.contactTestBitMask = ballCategory
            rightPlatform.physicsBody?.collisionBitMask = ballCategory
            addChild(rightPlatform)
            platforms.append(rightPlatform)
        }
        
        if Int.random(in: 0...4) == 0 { // 20% chance to add an obstacle
            let obstacleSize = CGSize(width: 30, height: 30)
            let obstacle = SKSpriteNode(color: .red, size: obstacleSize)
            obstacle.position = CGPoint(x: CGFloat.random(in: obstacleSize.width/2...(frame.width - obstacleSize.width/2)), y: platformY + platformHeight + obstacleSize.height / 2)
            obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
            obstacle.physicsBody?.isDynamic = false
            obstacle.physicsBody?.categoryBitMask = obstacleCategory
            obstacle.physicsBody?.contactTestBitMask = ballCategory
            obstacle.physicsBody?.collisionBitMask = 0
            addChild(obstacle)
            obstacles.append(obstacle)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard gameStarted else { return }
        
        if let data = motionManager.accelerometerData {
            let tilt = data.acceleration.x
            ball.physicsBody?.velocity.dx = CGFloat(tilt * 1000)
        }
        
        // Adjust the ball falling speed (e.g., slower fall speed)
        ball.position.y -= 3 // Slower fall speed
        
        for platform in platforms {
            // Adjust the platform movement speed (e.g., move up slower)
            platform.position.y += 10 / 25
            
            // Add horizontal movement to the platform
            let amplitude: CGFloat = 3
            let frequency: CGFloat = 3
            let offset = amplitude * sin(frequency * CGFloat(currentTime))
            
            // Ensure platforms do not overlap the hole
            let platformCenterX = platform.position.x + offset
            if platform.position.x < frame.width / 2 {
                // Left segment
                if platformCenterX + platform.size.width / 2 < frame.width / 2 - 10 {
                    platform.position.x += offset
                }
            } else {
                // Right segment
                if platformCenterX - platform.size.width / 2 > frame.width / 2 + 15 {
                    platform.position.x += offset
                }
            }
        }
        
        for obstacle in obstacles {
            obstacle.position.y += 10 / 25
            let amplitude: CGFloat = 3
            let frequency: CGFloat = 3
            let offset = amplitude * sin(frequency * CGFloat(currentTime))
            
            // Ensure platforms do not overlap the hole
            obstacle.position.x += offset
        }
        
        if ball.position.y <= 0 {
            gameOver(won: false)
        }
        
        if platforms.contains(where: { $0.position.y >= frame.maxY && ball.intersects($0) }) {
            gameOver(won: false)
        }
        
        if currentTime - gameStartTime >= 30 {
            gameOver(won: true)
        }
    }
    
    func gameOver(won: Bool) {
        gameStarted = false
        ball.isHidden = true
        for platform in platforms {
            platform.removeFromParent()
        }
        platforms.removeAll()
        
        for obstacle in obstacles {
            obstacle.removeFromParent()
        }
        obstacles.removeAll()
        timer?.invalidate()
        
        gameDelegate?.gameOver(won: won)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        if (contactA.categoryBitMask == ballCategory && contactB.categoryBitMask == platformCategory) ||
            (contactA.categoryBitMask == platformCategory && contactB.categoryBitMask == ballCategory) {
            // Handle collision between ball and platform
            print("Collision detected between ball and platform.")
        } else if (contactA.categoryBitMask == ballCategory && contactB.categoryBitMask == obstacleCategory) ||
                    (contactA.categoryBitMask == obstacleCategory && contactB.categoryBitMask == ballCategory) {
            // Handle collision between ball and obstacle
            gameOver(won: false)
        } else if (contactA.categoryBitMask == ballCategory && contactB.categoryBitMask == boundaryCategory) ||
                    (contactA.categoryBitMask == boundaryCategory && contactB.categoryBitMask == ballCategory) {
            // Handle collision between ball and boundary
            print("Collision detected between ball and boundary.")
        }
    }
}

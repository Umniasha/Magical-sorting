//
//  GameScene.swift
//  Magical sorting
//
//  Created by Oleg Arnaut  on 15.08.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var gameViewController : GameViewController!
    private var currentNode: SKNode?
    var oldPosition : CGPoint!
    var newPosition : CGPoint!
    
    var backShelf = SKSpriteNode()
    var objectArray = [SKSpriteNode]()
    var pointArray = [Point]()
    var gameObjectArray = [(String,String)]()
    var cellArray = [SKSpriteNode]()
    var objectSize = CGSize()
    var objectCount = Int()
    var isMoved = false
    var gameTimer = Timer()
    var gameTime = Int()
    var sizeText = CGFloat()
    var сoincidenceCount = Int()
    var isolateArray = [SKSpriteNode]()
    var isolateCount = Int()
    
    
    override func didMove(to view: SKView) {
        scene?.size = UIScreen.main.bounds.size
        if UIScreen.main.bounds.size.height > 800 {
            sizeText = 20
        } else {
            sizeText = 12
        }
        
        createShelf()
        createBG()
        objectSize = CGSize(width: backShelf.size.width / 11 , height: backShelf.size.height / 11)
        objectCount = 44
        createGameArray()
        createObject()
        
        checkLocation()
        checkEqual()
        gameTime = 150
        gameViewController.timerLable.titleLabel?.font =  UIFont(name: "BauhausITCbyBT-Heavy", size: sizeText)
        gameViewController.timerLable.titleLabel?.text = String(gameTime)
        gameViewController.timerLable.titleLabel?.textColor = .white
        gameViewController.timerLable.titleLabel?.textAlignment = .center
        сoincidenceCount = 3
        isolateCount = 3
        createIsolate()
       
      
   
    }
    
    func removeIsolation(){
        var array = isolateArray
        for isolate in array {
           
            if сoincidenceCount == 0 && isolate.name != nil{
                print(777)
                isolate.removeFromParent()
                isolate.name = nil
                сoincidenceCount = 3
            }
        }
    }
   
    func frontObject()->[SKNode]{
       
            
            var noBackObjectArray = [SKNode]()
            
            for object in self.children {
                for (key,_) in textureArray{
                    if object.name == key{
                        noBackObjectArray.append(object)
                    }
                }
            
            }
            return noBackObjectArray
    }
    
    
    func backObject() ->[SKSpriteNode]{
        var backObjectArray = [SKSpriteNode]()
        
        for  object in objectArray {
            for (_,value) in textureArray{
                if object.name == value{
                    
                    backObjectArray.append(object)
                   
                }
            }
        
        }
        return backObjectArray
        
 
    }
    
    
    func checkEqual()->[CGPoint]{
        var fullCell = [CGPoint]()
        for cellArray in cellArray {
            
       var array = [SKNode]()
       
            for object in frontObject() {
                
                    if cellArray.contains(object.position) {
                                array.append(object)

                
                }
            }
        
                if array.count == 3 && array[0].name == array[1].name && array[1].name == array[2].name{
                    self.сoincidenceCount -= 1
                    print(сoincidenceCount)
                        for i in 0..<objectArray.count {
                            if objectArray[i] == array[0] || objectArray[i] == array[1] || objectArray[i] == array[2]{
                                   

                                _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                                    self.objectArray[i].removeFromParent()
                                    
                                    
                                }
                            }
                    }
       
                } else  if array.count == 0 {
                    for BackObjectArray in backObject() {
                                                 if cellArray.contains(BackObjectArray.position) && BackObjectArray.zPosition == 6.0{
                                                 BackObjectArray.zPosition = 7
                                                     let name = BackObjectArray.name
                                            
                                                 for (key,value) in textureArray{
                                                     if value == name{
                                                       
                                                         BackObjectArray.name = key
                                                         BackObjectArray.texture = SKTexture(imageNamed: key)
                 
                                                 }
                                             }
                                                 } else if cellArray.contains(BackObjectArray.position) && BackObjectArray.zPosition == 5.0{
                                                     BackObjectArray.zPosition = 6
                                                 }
                                     }
                    
                }else if array.count == 3 {
                    
                       fullCell.append(cellArray.position)
                   
                }
            
        }
        
        return fullCell
       
    }
    
    
   
    

    
    override func update(_ currentTime: TimeInterval) {
        if isMoved{

            checkEqual()
            _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [self] _ in
                checkEqual()
            }
            _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [self] _ in
                checkEqual()
            }
            isMoved = false
        }
        if gameTime == 0{
            gameTimer.invalidate()
        }
        checkLocation()
        removeIsolation()
    }
    
    
    
    func checkLocation(){
       
        for i in pointArray.indices{
            pointArray[i].isAnabled = false
        }
        
       
        
        
        for object in frontObject(){
            for i in pointArray.indices{
              
                if Int(pointArray[i].point.x) == Int(object.position.x) &&
                    Int(pointArray[i].point.y) == Int(object.position.y)  &&
                    pointArray[i].isAnabled == false{
                    
                    pointArray[i].isAnabled = true
                    
                }
                
               
            }
        }
    }
    func chekIsolate()->[SKSpriteNode]{
        var array = [SKSpriteNode]()
        for cellArray in cellArray {
            if let scene = scene{
            for object in scene.children{
                if cellArray.contains(object.position){
                    if object.name == "isolation"{
                        
                        array.append(cellArray)
                    }
                }
            }
        }
        }
        return array
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let array = chekIsolate()
       
        newPosition = nil
        var location : CGPoint!
        if let touch = touches.first {
           
            if array.isEmpty{
                location = touch.location(in: self)
          
            } else  if !array.isEmpty{
                var notPosition = SKSpriteNode()
                for cell in array{
                    
                        
                            if cell.contains(touch.location(in: self))  {
                                notPosition = cell

                        }
                        
                    }
                if !notPosition.contains(touch.location(in: self)){
                    location = touch.location(in: self)
                }
                
            }
            
            if let location = location{
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
               
                    for object in frontObject() {
                    
                        if node.name == object.name {
                            
                                    
                                
                                self.currentNode = node
                                oldPosition = node.position
                        
                            
                            
                            
                            
                            
                           
                        }
                    }
                }
               
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //checkLocation()
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
            node.zPosition = 150
           
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
        if let node = self.currentNode{
            
           pointArray.sort(by: {calculateDistance(object: node.position, point: $0.point) < calculateDistance(object: node.position, point: $1.point)})
            var newArray = [Point]()
            for i in pointArray.indices {
                if pointArray[i].isAnabled == false {
                    newArray.append(pointArray[i])
                }
            }
          
            if let point = newArray.first?.point{
                if calculateDistance(object: node.position, point: point ) <= node.frame.size.width {
                newPosition = newArray.first?.point
                    if !gameTimer.isValid {
                        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {  _ in
                            
                            self.gameTime -= 1
                            
                            self.gameViewController.timerLable.titleLabel?.font =  UIFont(name: "BauhausITCbyBT-Heavy", size: self.sizeText)
                            self.gameViewController.timerLable.titleLabel?.text = String(self.gameTime)
                            self.gameViewController.timerLable.titleLabel?.textColor = .white
                            self.gameViewController.timerLable.titleLabel?.textAlignment = .center
                            
                        }
                    }
                }
            }

            if let newPosition = newPosition{
                
               // checkEqual()
               isMoved = true
                node.position = newPosition
                node.zPosition = 7
            
            } else {
                if let objectPosition = oldPosition{
                    let timeDuration = CGFloat(sqrt((node.position.x - objectPosition.x) * (node.position.x - objectPosition.x) + (node.position.y - objectPosition.y) * (node.position.y - objectPosition.y)) / 500)
                    node.run(SKAction.move(to: objectPosition, duration: timeDuration))
                    node.zPosition = 7
           
                }
            }
        }
        self.currentNode = nil
        
        newPosition = nil
        oldPosition = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        checkLocation()
        
        self.currentNode = nil
        if let node = currentNode{
            
        if let objectPosition = oldPosition{
        let timeDuration = CGFloat(sqrt((node.position.x - objectPosition.x) * (node.position.x - objectPosition.x) + (node.position.y - objectPosition.y) * (node.position.y - objectPosition.y)) / 500)
        node.run(SKAction.move(to: objectPosition, duration: timeDuration))
            node.zPosition -= 1
        }
        }
        newPosition = nil
        oldPosition = nil
    }
    


    
    func calculateDistance(object: CGPoint, point: CGPoint) -> CGFloat{
        var distance  = CGFloat()
        distance = sqrt(((object.x - point.x) * (object.x - point.x)) + ((object.y - point.y) * (object.y - point.y)))
        
        return distance
    }
    
    func createGameArray(){
        var array = [(String,String)]()
        for _ in 1...objectCount{
            array.append(textureArray.randomElement()!)
        }
         gameObjectArray = array + array + array
      
    }

    func createObject(){
      
        var array = pointArray.shuffled()
        
            if gameObjectArray.count <= 42 {
                for (key,_) in gameObjectArray{
                objectArray.append(Objects(name: key,
                                       size: objectSize,
                                       position: array.removeFirst().point,
                                 zPosition: 7).createNode())
                }
            } else if gameObjectArray.count > 42 && gameObjectArray.count <= 87 {
                array.removeAll()
                array = pointArray.shuffled()
                for i in 0..<42{
                    objectArray.append(Objects(name: gameObjectArray[i].0,
                                       size: objectSize,
                                       position: array.removeFirst().point,
                                 zPosition: 7).createNode())
            }
                array.removeAll()
                array = pointArray.shuffled()
                for i in 42..<gameObjectArray.count {
                    objectArray.append(Objects(name: gameObjectArray[i].1,
                                           size: objectSize,
                                           position: array.removeFirst().point,
                                     zPosition: 6).createNode())
                }
            
            } else if gameObjectArray.count > 87 && gameObjectArray.count <= 132{
                
                array.removeAll()
                array = pointArray.shuffled()
                    for i in 0..<42{
                        objectArray.append(Objects(name: gameObjectArray[i].0,
                                       size: objectSize,
                                       position: array.removeFirst().point,
                                 zPosition: 7).createNode())
                    }
                
                array.removeAll()
                
                array = pointArray.shuffled()
                    for i in 42..<87 {
                        objectArray.append(Objects(name: gameObjectArray[i].1,
                                           size: objectSize,
                                           position: array.removeFirst().point,
                                     zPosition: 6).createNode())
                    }
                
                array.removeAll()
                array = pointArray.shuffled()
                    for i in 87..<gameObjectArray.count {
                        objectArray.append(Objects(name: gameObjectArray[i].1,
                                           size: objectSize,
                                           position: array.removeFirst().point,
                                     zPosition: 5).createNode())
                    }
            
            }
        
        
       
        for object in objectArray {
            addChild(object)
        }

       
    }
    
    func createIsolate(){
        
        var arrayCell = checkEqual().shuffled()
       
        for _ in 0..<isolateCount{
            
            
            let isolation = SKSpriteNode(imageNamed: "isolation")
            isolation.size = CGSize(width: cellArray[0].size.width - 1, height: cellArray[0].size.height - 1)
            isolation.name = "isolation"
            isolation.position = arrayCell.removeFirst()
            isolation.zPosition = 8
            let lable = SKLabelNode()
            lable.text = String(сoincidenceCount)
            lable.fontName = "BauhausITCbyBT-Heavy"
            lable.fontSize = sizeText
            lable.zPosition = 9
            lable.fontColor = .black
            lable.position.y = -isolation.size.height / 4
            isolation.addChild(lable)
            
            isolateArray.append(isolation)
        }
        
        for isolate in isolateArray{
            
            addChild(isolate)
        }
        
    }
    
   
    
    func createShelf(){
        backShelf = SKSpriteNode(imageNamed: "backShelf")
        backShelf.size = CGSize(width: self.scene!.frame.size.width, height: self.scene!.frame.size.height / 1.8)
        backShelf.zPosition = 0
        addChild(backShelf)
        

        var horyzontalSticks = [SKSpriteNode]()
        for _ in 1...5{
        let hStick = SKSpriteNode(imageNamed: "horizontalStick")
        hStick.size = CGSize(width: backShelf.size.width, height: backShelf.size.width / 24)
            hStick.position.y = backShelf.frame.maxY  - hStick.size.height
        hStick.zPosition = 3
        horyzontalSticks.append(hStick)
        }
        var yPos = backShelf.frame.maxY  - backShelf.size.height / 5
        for stick in horyzontalSticks {
            stick.position.y = yPos
            addChild(stick)
            yPos -=  backShelf.size.height / 5
        }
        
        
        var verticalSticks = [SKSpriteNode]()
        for _ in 1...4{
        let vStick = SKSpriteNode(imageNamed: "verticalStick")
            vStick.size = CGSize(width: backShelf.size.width / 20, height: backShelf.size.height)
            vStick.position.y = backShelf.position.y
            vStick.zPosition = 2
            verticalSticks.append(vStick)
        }
        var xPos = backShelf.frame.minX
        for stick in verticalSticks {
            stick.position.x = xPos
            addChild(stick)
            xPos +=  backShelf.size.width / 3
        }
        
       var name = 1
        for _ in 1...15{
        let shadowPlate = SKSpriteNode(imageNamed: "shadow")
            shadowPlate.name = String(name)
            shadowPlate.size = CGSize(width: backShelf.size.width / 3, height: backShelf.size.height / 5)
            shadowPlate.zPosition = 1
            cellArray.append(shadowPlate)
            name += 1
        }
        var shadowPos = CGPoint(x: backShelf.frame.minX + backShelf.size.width / 6, y: backShelf.frame.minY + backShelf.size.height / 10 )
        for i in 0...4{
            cellArray[i].position = shadowPos
            addChild(cellArray[i])
            let point = Point(point: CGPoint(x: cellArray[i].position.x - (cellArray[i].size.width / 3.5) , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            let point1 = Point(point: CGPoint(x: cellArray[i].position.x  , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            let point2 = Point(point: CGPoint(x: cellArray[i].position.x + (cellArray[i].size.width / 3.5) , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            pointArray.append(point)
            pointArray.append(point1)
            pointArray.append(point2)
            shadowPos.y += backShelf.size.height / 5
        }
        
        shadowPos = CGPoint(x: backShelf.frame.midX, y: backShelf.frame.minY + backShelf.size.height / 10 )
        for i in 5...9{
            cellArray[i].position = shadowPos
            addChild(cellArray[i])
            let point = Point(point: CGPoint(x: cellArray[i].position.x - (cellArray[i].size.width / 3.5) , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            let point1 = Point(point: CGPoint(x: cellArray[i].position.x  , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            let point2 = Point(point: CGPoint(x: cellArray[i].position.x + (cellArray[i].size.width / 3.5) , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            pointArray.append(point)
            pointArray.append(point1)
            pointArray.append(point2)
            shadowPos.y += backShelf.size.height / 5
        }
        
        shadowPos = CGPoint(x: backShelf.frame.maxX - backShelf.size.width / 6 , y: backShelf.frame.minY + backShelf.size.height / 10 )
        for i in 10...14{
            cellArray[i].position = shadowPos
            addChild(cellArray[i])
            let point = Point(point: CGPoint(x: cellArray[i].position.x - (cellArray[i].size.width / 3.5) , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            let point1 = Point(point: CGPoint(x: cellArray[i].position.x  , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            let point2 = Point(point: CGPoint(x: cellArray[i].position.x + (cellArray[i].size.width / 3.5) , y: cellArray[i].position.y - cellArray[i].size.height / 5), isAnabled: false)
            pointArray.append(point)
            pointArray.append(point1)
            pointArray.append(point2)
            shadowPos.y += backShelf.size.height / 5
        }
        
        
        let topShelf = SKSpriteNode(imageNamed: "topShelf")
        topShelf.size = CGSize(width: backShelf.size.width, height: backShelf.size.width / 8)
        topShelf.position.y = backShelf.frame.maxY
        topShelf.zPosition = 3
        addChild(topShelf)
        
        let stars = SKSpriteNode(imageNamed: "stars")
        stars.size = CGSize(width: topShelf.size.width / 1.4, height: topShelf.size.height)
        stars.position.y = topShelf.frame.maxY  + topShelf.size.height / 1.8
        addChild(stars)
        
   
    }
    

    
    func createBG(){
        let backGround = SKSpriteNode(imageNamed: "bg")
        backGround.size = self.scene!.frame.size
        backGround.name = "bg"
        backGround.zPosition = -1
        addChild(backGround)
        
    }
}

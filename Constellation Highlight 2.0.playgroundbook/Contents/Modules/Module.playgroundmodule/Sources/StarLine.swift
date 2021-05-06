
import SpriteKit
class StarLine : SKShapeNode{
    init(Path:CGPath){
        super.init()
        self.name = "line"
        self.path = Path
        self.strokeColor = #colorLiteral(red: 0.7243896127, green: 0.1764317751, blue: 0.3655595779, alpha: 1.0)
        self.lineWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
    
    func attPath(Path: CGPath){
        self.path = Path
    }
    
    func createBody(){
        let body = SKPhysicsBody(edgeChainFrom: self.path!)
        self.physicsBody = body
        body.categoryBitMask = 0x1 << 1
        body.collisionBitMask = 0
        body.contactTestBitMask =  1
        body.affectedByGravity = false
        body.isDynamic = true
    }
}


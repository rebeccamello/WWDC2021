import SpriteKit

public class Star{
    var x: CGFloat
    var y: CGFloat
    var color: UIColor
    var radius: CGFloat
    var vx: CGFloat
    var vy: CGFloat
    var xPosition: CGFloat = 0
    var yPosition: CGFloat = 0
    
    
    init (){ 
        x = 0
        y = 0
        color = #colorLiteral(red: 0.9999018311500549, green: 1.0000687837600708, blue: 0.9998798966407776, alpha: 1.0)
        radius = 10
        vx = 0
        vy = 0
    }
    
    init(x: CGFloat, y: CGFloat, color: UIColor, radius: CGFloat, vx: CGFloat, vy: CGFloat){
        self.x = x
        self.y = y
        self.color = color 
        self.radius = radius
        self.vx = vx
        self.vy = vy
    }
    
    // retorna a forma pra desenhar na tela
    lazy var node = SKShapeNode(circleOfRadius: self.radius)
    func getShape() -> SKShapeNode{
        node.position = CGPoint(x: self.xPosition, y: self.yPosition)
        node.lineWidth = 0
        node.fillColor = self.color
        return node
    }
    
    func goBackToOriginalSize(){
        let action = SKAction.scale(to: 1, duration: 0)
        node.run(action)
    }
}

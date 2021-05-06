
import Foundation
import SpriteKit

class Button: SKNode{
    var image: SKSpriteNode?
    var action: (() -> Void)?
    
    init(image: SKSpriteNode, action: @escaping () -> Void){
        self.image = image
        self.action = action
        super.init()
        self.isUserInteractionEnabled = true // deixa o usuario interagir
        self.addChild(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.action?()
    }
}

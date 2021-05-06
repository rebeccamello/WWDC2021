
import UIKit
import SpriteKit  

public class CruzeiroViewController: UIViewController{
    public override func viewDidLoad() { 
        super.viewDidLoad() 
        let view = SKView() 
        let scene = Cruzeiro() 
        scene.scaleMode = .resizeFill 
        view.presentScene(scene) 
        self.view = view 
    }
}


import UIKit
import SpriteKit  

public class ArtViewController: UIViewController{
    
    public override func viewDidLoad() { 
        super.viewDidLoad() 
        let view = SKView() 
        let scene = ArtScene() 
        scene.scaleMode = .resizeFill 
        view.presentScene(scene)
        self.view = view 
    }
}

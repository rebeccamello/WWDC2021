
import UIKit
import SpriteKit  

public class SunEarthViewController: UIViewController{
    public override func viewDidLoad() { 
        super.viewDidLoad() 
        let view = SKView() 
        let scene = SunEarth() 
        scene.scaleMode = .resizeFill 
        view.presentScene(scene) 
        self.view = view 
    }
}


import UIKit
import SpriteKit  

public class LibraViewController: UIViewController{
    public override func viewDidLoad() { 
        super.viewDidLoad() 
        let view = SKView() 
        let scene = Libra() 
        scene.scaleMode = .resizeFill 
        view.presentScene(scene) 
        self.view = view 
    }
}

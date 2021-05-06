
import UIKit
import SpriteKit
import AVFoundation


public class ArtScene: SKScene, AVAudioPlayerDelegate{
    
    var constelacao: Constelacao = Constelacao(col: 15, linhas: 15, radius: 1)
    var colors: [UIColor] = [#colorLiteral(red: 0.9999960065, green: 1.0, blue: 1.0, alpha: 1.0)]
    var grama: SKSpriteNode = SKSpriteNode(imageNamed: "Grama.png")
    var menina: SKSpriteNode = SKSpriteNode(imageNamed: "menFrente2.png")
    var lua: SKSpriteNode = SKSpriteNode(imageNamed: "Lua.png")
    var soundButtonOff: SKSpriteNode = SKSpriteNode(imageNamed: "soundOn.png")
    var count = 0
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        loopMusic()
    }
    
    public override func didChangeSize(_ oldSize: CGSize){
        resize(node: menina, scale: 0.7)
        menina.position = CGPoint(x: size.width/2, y: 0 + menina.size.height*0.5)
        
        grama.setScale(2)
        grama.position = CGPoint(x: size.width / 2, y: 200)
        
        resize(node: lua, scale: 0.2)
        
        soundButtonOff.name = "desligarSom"
        soundButtonOff.setScale(0.2)
        soundButtonOff.position = CGPoint(x: 55, y: self.size.height - 55)
        
        lua.position = CGPoint(x: size.width - 100, y: size.height - 100)
        draw()
    }
    
    func resize(node: SKSpriteNode, scale: CGFloat){
        if (self.size.width > 0){
            let w = node.size.width
            let h = node.size.height
            var nw = self.size.width*scale
            var nh = (h*nw)/w
            node.scale(to: CGSize(width: nw, height: nh))
        }
    }
    
    func draw(){
        self.removeAllChildren()
        let stars = constelacao.stars
        
        for star in stars{
            star.xPosition = CGFloat.random(in: 0...self.size.width)
            star.yPosition = CGFloat.random(in: 0...self.size.height)
            self.addChild(star.getShape())
        }
        
        self.addChild(grama)
        self.addChild(menina)
        self.addChild(lua)
        self.addChild(soundButtonOff)
        
        let texture: [SKTexture] = [SKTexture(imageNamed: "menFrente2.png"),
                                    SKTexture(imageNamed: "meninaFrente2.png"),
                                    SKTexture(imageNamed: "meninaFrente3.png"),
                                    SKTexture(imageNamed: "meninaFrente4.png"), SKTexture(imageNamed: "meninaFrente5.png"),
                                    SKTexture(imageNamed: "meninaFrente4.png"),
                                    SKTexture(imageNamed: "meninaFrente3.png"),
                                    SKTexture(imageNamed: "meninaFrente2.png"),
                                    SKTexture(imageNamed: "menFrente2.png")]
        for t in texture{
            t.filteringMode = .nearest
        }
        let idleAnimation = SKAction.animate(with: texture, timePerFrame: 0.04)
        let loop = SKAction.repeatForever(idleAnimation)
        menina.run(loop)
        
        let gramaMelhor: [SKTexture] = [SKTexture(imageNamed: "Grama.png")]
        for t in gramaMelhor{
            t.filteringMode = .nearest
        }
        let luaMelhor: [SKTexture] = [SKTexture(imageNamed: "Lua.png")]
        for t in luaMelhor{
            t.filteringMode = .nearest
        }
    }
    
    private var backgroundSound: AVAudioPlayer?
    func loopMusic() {
            backgroundSound?.delegate = self
            guard let path = Bundle.main.path(forResource: "MusicaReAcademy", ofType:"m4a") else { return }
            let url = URL(fileURLWithPath: path)
            do{
                backgroundSound = try AVAudioPlayer(contentsOf: url)
                backgroundSound?.volume = 0.1
                backgroundSound?.play()
                backgroundSound?.numberOfLoops = -1
            }catch{
                print("Problem with audio")
            }
        }
    
    // faz a acao de desligar a musica
    public func mudarBotaoSom() {
        self.count += 1 // toda vez que clica no botao, incrementa o contador
        if (self.count % 2 == 1){ // se for ímpar, para a musica
                self.backgroundSound?.volume = 0.0
            self.soundButtonOff.texture = SKTexture(imageNamed: "soundOff.png")
            self.soundButtonOff.name = "desligarSom"
            self.soundButtonOff.setScale(0.2)
            self.soundButtonOff.position = CGPoint(x: 55, y: self.size.height - 55)
        }
        
        else{ // se for par, volta a tocar
                self.backgroundSound?.volume = 0.1
            self.soundButtonOff.texture = SKTexture(imageNamed: "soundOn.png")
            self.soundButtonOff.name = "desligarSom"
            self.soundButtonOff.setScale(0.2)
            self.soundButtonOff.position = CGPoint(x: 55, y: self.size.height - 55)
        }
        
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let scene = self
        if let touch = touches.first{
            let location = touch.location(in: scene)
            let touchedNodes = scene.nodes(at: location)
            for node in touchedNodes.reversed(){
                if node.name == "desligarSom"{
                    scene.mudarBotaoSom()
                }
            }
        }
    }
}





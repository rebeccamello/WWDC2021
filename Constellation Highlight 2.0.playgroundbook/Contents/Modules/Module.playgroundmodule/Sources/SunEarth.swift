

import UIKit
import SpriteKit
import AVFoundation


public class SunEarth: SKScene, AVAudioPlayerDelegate{
    
    var constelacao: Constelacao = Constelacao(col: 15, linhas: 15, radius: 1)
    var colors: [UIColor] = [#colorLiteral(red: 0.9999960065, green: 1.0, blue: 1.0, alpha: 1.0)]
    var earth: SKSpriteNode = SKSpriteNode(imageNamed: "sprite_00.png")
    var radiusx: CGFloat = 220
    var radiusy: CGFloat = 126
    var sun: SKSpriteNode = SKSpriteNode(imageNamed: "Sol.png")
    var angle: CGFloat = 0
    var center1: CGPoint = CGPoint(x: 0, y: 0)
    var soundButtonOff: SKSpriteNode = SKSpriteNode(imageNamed: "soundOn.png")
    var count = 0
    
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view) 
        backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        loopMusic()
    }
    
    public override func didChangeSize(_ oldSize: CGSize){ 
        //earth.setScale(0.15)
        resize(node: earth, scale: 0.13)
        earth.position = CGPoint(x: self.size.width/2 + 20, y: self.size.height/2)
        //sun.setScale(0.5)
        resize(node: sun, scale: 0.5)
        sun.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        center1 = CGPoint(x: self.size.width/2, y: self.size.height/2 - 10)
        
        soundButtonOff.name = "desligarSom"
        soundButtonOff.setScale(0.2)
        soundButtonOff.position = CGPoint(x: 55, y: self.size.height - 55)
        
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
        var c = SKShapeNode(ellipseOf: CGSize(width: size.width*0.8, height: 250*size.width*0.8 / 450))
        c.position = CGPoint(x: size.width/2+10, y: size.height/2 - 20)
        
        for star in stars{
            star.xPosition = CGFloat.random(in: 0...self.size.width) 
            star.yPosition = CGFloat.random(in: 0...self.size.height) 
            self.addChild(star.getShape())
        }
        
        self.addChild(c)
        self.addChild(earth)
        self.addChild(sun)
        self.addChild(soundButtonOff)

        
        let texture: [SKTexture] = [SKTexture(imageNamed: "sprite_00.png"), 
                                    SKTexture(imageNamed: "sprite_01.png"),
                                    SKTexture(imageNamed: "sprite_02.png"),
                                    SKTexture(imageNamed: "sprite_03.png"), 
                                    SKTexture(imageNamed: "sprite_04.png"),
                                    SKTexture(imageNamed: "sprite_05.png"), 
                                    SKTexture(imageNamed: "sprite_06.png"),
                                    SKTexture(imageNamed: "sprite_07.png"),
                                    SKTexture(imageNamed: "sprite_08.png"),
                                    SKTexture(imageNamed: "sprite_09.png"),
                                    SKTexture(imageNamed: "sprite_10.png"),
                                    SKTexture(imageNamed: "sprite_11.png"),
                                    SKTexture(imageNamed: "sprite_12.png"),]
        for t in texture{
            t.filteringMode = .nearest
        }
        let idleAnimation = SKAction.animate(with: texture, timePerFrame: 0.1)
        let loop = SKAction.repeatForever(idleAnimation)
        earth.run(loop)
        let sunMelhor: [SKTexture] = [SKTexture(imageNamed: "Sol.png")]
        for t in sunMelhor{
            t.filteringMode = .nearest
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        earth.position.x = center1.x+2 + size.width*0.39 * cos(angle)
        earth.position.y = center1.y + 251*size.width*0.8/900  * sin(angle)
        angle += 0.01
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





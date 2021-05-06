
import UIKit
import SpriteKit
import AVFoundation

public class Cruzeiro: SKScene, SKPhysicsContactDelegate, AVAudioPlayerDelegate{
    
    var constelacao: Constelacao = Constelacao(col: 15, linhas: 15, radius: 1)
    var colors: [UIColor] = [#colorLiteral(red: 0.9999960065, green: 1.0, blue: 1.0, alpha: 1.0)]
    var grama: SKSpriteNode = SKSpriteNode(imageNamed: "Grama2.png")
    var menina: SKSpriteNode = SKSpriteNode(imageNamed: "menCruz1.png")
    var cruzSul: Constelacao = Constelacao(col: 3, linhas: 3, radius: 5)
    var line: [StarLine] = []
    var path: CGMutablePath = CGMutablePath()
    var button: Button
    var soundButtonOff: SKSpriteNode = SKSpriteNode(imageNamed: "soundOn.png")
    var count = 0
    
    public override init(){
        let image = SKSpriteNode(imageNamed: "reset.png")
        button = Button(image: image){
            print("Apertou")
        }
        super.init(size: .zero)
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
        
        button.setScale(0.12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        loopMusic()
    }
    
    public override func didChangeSize(_ oldSize: CGSize){
        menina.setScale(self.size.height/1000)
     
        grama.setScale(self.size.height/2000)
        grama.position = CGPoint(x: self.size.width / 2, y: grama.size.height/2)
        
        menina.position = CGPoint(x: 0 + size.width/4, y: grama.size.height/2+40)
        button.position = CGPoint(x: 80, y: self.size.height - 41)
        
        soundButtonOff.name = "desligarSom"
        soundButtonOff.setScale(0.17)
        soundButtonOff.position = CGPoint(x: 190, y: self.size.height - 43)
        
        draw()
        
    }
    
    
    private func positionCruz(){
        let cruzeiroStars = cruzSul.stars
        
        for star in cruzeiroStars{
            let body = SKPhysicsBody(circleOfRadius: 10)
            star.getShape().physicsBody = body
            body.isDynamic = true
            body.affectedByGravity = false
            body.categoryBitMask = 1
            body.contactTestBitMask = 0x1 << 1
            body.collisionBitMask = 0
        }
        
        let topY = self.size.height * 0.75
        let midX = self.size.width * 0.5
        let midY = self.size.height * 0.5
        
            // estrela mais de cima
        cruzeiroStars[0].xPosition = midX
        cruzeiroStars[0].yPosition = topY

        
            // estrela mais de baixo
        cruzeiroStars[1].xPosition = midX + 10
        cruzeiroStars[1].yPosition = midY
        
            // da direita
        cruzeiroStars[2].xPosition = midX + 60
        cruzeiroStars[2].yPosition = topY * 0.9
        
            // da esquerda
        cruzeiroStars[3].xPosition = midX - 60
        cruzeiroStars[3].yPosition = topY * 0.9 - 30
    }
    
    
    func draw(){
        self.removeAllChildren()
        let stars = constelacao.stars
        let cruzeiroStars = cruzSul.stars
        positionCruz()
        
        for star in stars{
            star.xPosition = CGFloat.random(in: 0...self.size.width)
            star.yPosition = CGFloat.random(in: 0...self.size.height)
            self.addChild(star.getShape())
        }
        
        for star in cruzeiroStars{
            self.addChild(star.getShape())
        }
        
        self.addChild(grama)
        self.addChild(menina)
        self.addChild(button)
        self.addChild(soundButtonOff)
        
        let texture: [SKTexture] = [SKTexture(imageNamed: "menCruz1.png"),
                                    SKTexture(imageNamed: "menCruz1.png"),
                                    SKTexture(imageNamed: "menCruz2.png"),
                                    SKTexture(imageNamed: "menCruz3.png"),
                                    SKTexture(imageNamed: "menCruz4.png"),
                                    SKTexture(imageNamed: "menCruz3.png"),
                                    SKTexture(imageNamed: "menCruz2.png"), SKTexture(imageNamed: "menCruz1.png")]
        for t in texture{
            t.filteringMode = .nearest
        }
        let idleAnimation = SKAction.animate(with: texture, timePerFrame: 0.25)
        let loop = SKAction.repeatForever(idleAnimation)
        menina.run(loop)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // toque na tela (faz o desenho)
        for touch in touches{
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            didBeginTouch(at: touch.location(in: self))
        }
        
        // botao da musica
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
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            didContinueTouch(at: touch.location(in: self))
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            didEndTouch(at: touch.location(in: self))
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            didEndTouch(at: touch.location(in: self))
        }
    }
    
    
    private func didBeginTouch(at position: CGPoint){
        path.move(to: position)
        let line = StarLine(Path: path)
        self.line.append(line)
        self.addChild(line)
    }
    
    private func didContinueTouch(at position: CGPoint){
        path.addLine(to: position)
        self.line[self.line.count-1].attPath(Path: path)
        self.line[self.line.count-1].createBody()
    }
    
    private func didEndTouch(at position: CGPoint){
        path = CGMutablePath()
    }
    
    
    // faz a acao de apagar a linha
    public override func sceneDidLoad() {
        super.sceneDidLoad()
        button.action = { [weak self] in
            guard let self = self else {return}
            self.removeChildren(in: self.line)
            self.line.removeAll(keepingCapacity: false)
            self.path = CGMutablePath()
            for star in self.cruzSul.stars{
                star.getShape().physicsBody?.isDynamic = true
                star.getShape().fillColor = .white
                star.node.removeAllActions()
                star.goBackToOriginalSize()
            }
            self.count = 0
            
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        count += 1
        if (contact.bodyA.categoryBitMask == 1){
            if let star = contact.bodyA.node as? SKShapeNode{
                let up = SKAction.scale(to: 2, duration: 0.5)
                let down = SKAction.scale(to: 0.5, duration: 0.5)
                let repete = SKAction.repeatForever(SKAction.sequence([up,down]))
                star.run(repete)
            }
            contact.bodyA.isDynamic = false
        }else{
            if let star = contact.bodyB.node as? SKShapeNode{
                let up = SKAction.scale(to: 2, duration: 0.5)
                let down = SKAction.scale(to: 0.5, duration: 0.5)
                let repete = SKAction.repeatForever(SKAction.sequence([up,down]))
                star.run(repete)
            }
            contact.bodyB.isDynamic = false
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
            self.soundButtonOff.setScale(0.17)
            self.soundButtonOff.position = CGPoint(x: 190, y: self.size.height - 43)
        }
        
        else{ // se for par, volta a tocar
            self.backgroundSound?.volume = 0.1
            self.soundButtonOff.texture = SKTexture(imageNamed: "soundOn.png")
            self.soundButtonOff.name = "desligarSom"
            self.soundButtonOff.setScale(0.17)
            self.soundButtonOff.position = CGPoint(x: 190, y: self.size.height - 43)
        }
        
    }
}




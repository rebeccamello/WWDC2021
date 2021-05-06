
// criacao logica da constelacao
import Foundation
import CoreGraphics

final class Constelacao{
    var stars: [Star] = []
    var col: Int
    var linhas: Int
    var numberOfElements: Int
    var radius: CGFloat
    
    init(col: Int, linhas: Int, radius: CGFloat){
        self.col = col
        self.linhas = linhas
        self.numberOfElements = col*linhas
        self.radius = radius
        createElem()
    }
    
    func findElem(by xPosition: Int, by yPosition: Int) -> Int?{
        if xPosition >= 0 && yPosition >= 0 {
            let index = (yPosition * col) + xPosition
            if index <= numberOfElements,
               xPosition < col,
               yPosition < numberOfElements / col {
                return index
            }
        }
        return nil
    }
    
    func findElementPosition(by index: Int) -> (Int, Int)? {
        if index <= numberOfElements {
            let xPosition = index / col
            let yPosition = index % col
            return (xPosition, yPosition)
        }
        return nil
    }
    
    private func createElem(){
        for index in 0..<numberOfElements{
            guard let xPosition = findElementPosition(by: index)?.0 else {return}
            guard let yPosition = findElementPosition(by: index)?.1 else {return}
            let star = Star(x: CGFloat(xPosition), y: CGFloat(yPosition), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), radius: radius, vx: 0, vy: 0)
            self.stars.append(star)
        }
    }
    
}

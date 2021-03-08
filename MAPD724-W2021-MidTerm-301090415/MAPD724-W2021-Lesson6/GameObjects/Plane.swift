import SpriteKit
import GameplayKit

class Plane: GameObject
{
    
    init()
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start()
    {
        zPosition = 2
        position = CGPoint(x: 0, y: -495)
    }
    
    override func Update()
    {
        CheckBounds()
    }
    
    override func CheckBounds()
    {
        if(position.x <= -310)
        {
            position.x = -310
        }
        
        if(position.x >= 310)
        {
            position.x = 310
        }
        
    }
    
    override func UpdateLandscape()
    {
        CheckBoundsLandscape()
    }
    
    override func CheckBoundsLandscape()
    {
        if(position.y <= -310)
        {
            position.y = -310
        }
        
        if(position.y >= 310)
        {
            position.y = 310
        }
        
    }
    
    func TouchMove(newPos: CGPoint)
    {
        position = newPos
    }
}

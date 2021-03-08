import UIKit
import AVFoundation
import SpriteKit
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

class GameScene: SKScene, CanReceiveTransitionEvents
{
    
    var ocean: Ocean?
    var island: Island?
    var plane: Plane?
    var clouds: [Cloud] = []
    var isPortraitOrientation = true
    override func didMove(to view: SKView)
    {
        screenWidth = frame.width
        screenHeight = frame.height
        name = "GAME"
        
        ocean = Ocean()
        plane = Plane()
        island = Island()
        for _ in 0...1
        {
            let cloud: Cloud = Cloud()
            clouds.append(cloud)
        }
        viewDidTransition()
        addChild(ocean!)
        addChild(plane!)
        addChild(island!)
        
        for cloud in clouds
        {
            addChild(cloud)
        }
        
        let engineSound = SKAudioNode(fileNamed: "engine.mp3")
        self.addChild(engineSound)
        engineSound.autoplayLooped = true
        
        do {
            let sounds:[String] = ["thunder", "yay"]
            for sound in sounds
            {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
	                let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        } catch {
        }
        
    }
    
    func isPortrait() -> Bool {
        return (UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isPortrait) ?? true
    }
    
    func movePlane(atPoint pos : CGPoint) {
        if (isPortrait())
        {
            plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
        } else {
            plane?.TouchMove(newPos: CGPoint(x: -495, y: pos.y))
        }
    }
    
    func touchDown(atPoint pos : CGPoint)
    {
        movePlane(atPoint: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        movePlane(atPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        movePlane(atPoint: pos)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval)
    {

        if (isPortraitOrientation) {
            ocean?.Update()
            island?.Update()
            plane?.Update()
            
            for cloud in clouds
            {
                cloud.Update()
            }
        } else {
            ocean?.UpdateLandscape()
            island?.UpdateLandscape()
            plane?.UpdateLandscape()
            
            for cloud in clouds
            {
                cloud.UpdateLandscape()
            }
        }

        CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: island!)
        for cloud in clouds
        {
            CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: cloud)
        }
        
    }
    
    func viewDidTransition()
    {
        let willBePortrait = isPortrait()
        if willBePortrait != isPortraitOrientation {
            size = CGSize(width: size.height, height: size.width)
            screenWidth = frame.width
            screenHeight = frame.height
            ocean?.Rotate(isPortrait: willBePortrait)
            plane?.Rotate(isPortrait: willBePortrait)
            island?.Rotate(isPortrait: willBePortrait)
            for cloud in clouds
            {
                cloud.Rotate(isPortrait: willBePortrait)
            }
            
        }
        isPortraitOrientation = willBePortrait
    }
}

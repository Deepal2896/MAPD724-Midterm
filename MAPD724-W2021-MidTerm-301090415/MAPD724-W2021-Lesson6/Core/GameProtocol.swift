protocol GameProtocol
{
    //initiate object
    func Start()
    
    // checks position of the object and resets it when object is outside the screen
    func CheckBounds()
    
    // CheckBounds method when device is in landscape mode
    func CheckBoundsLandscape()
    
    // reset object position when object is outside the screen
    func Reset()
    
    // Reset method when device is in landscape mode
    func ResetLandscape()
    
    // lifecycle method, updates the position of object and 
    func Update()
    
    // Update method when device is in landscape mode
    func UpdateLandscape()
    
    // rotate object and depending on the orientation change its position on the screen, its dx dy speed ...
    // since coordinate center is in middle of the screen we need to change position
    // T - plane
    // landscape  ->   portait
    // __________      ________
    // |T       |      |      |
    // |        |   -> |      |
    // |        |      |      |
    // ----------      |      |
    //                 |T     |
    //                 --------
    func Rotate(isPortrait: Bool)
    
}

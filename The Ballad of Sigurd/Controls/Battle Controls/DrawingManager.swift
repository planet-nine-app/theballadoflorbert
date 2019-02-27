//
//  DrawingManager.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/27/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func radiansToDegrees() -> Double {
        return self * 180.0 / .pi
    }
}

struct DirectionCoordinator {
    var direction0: Direction = .none
    var direction1: Direction = .none
    var direction2: Direction = .none
    var direction3: Direction = .none
    
    mutating func reset() {
        direction0 = .none
        direction1 = .none
        direction2 = .none
        direction3 = .none
    }
    
    func isUp(x: Double, y: Double) -> Bool {
        if(x > 70 && x < 110 && y > 70 && y < 110) {
            return true
        }
        return false
    }
    
    func isDown(x: Double, y: Double) -> Bool {
        if(x > 70 && x < 110 && y > -110 && y < -70) {
            return true
        }
        return false
    }
    
    func getDirectionFromAngles(arcsin: Double, arccos: Double) -> Direction {
        var direction = Direction.none
        var left = false
        var right = false
        var up = false
        var down = false
        let sum = arcsin + arccos
        
        if sum < 33 {
            right = true
        } else {
            left = true
        }
        if((!arcsin.isNaN && !arcsin.isInfinite) && abs(Int32(arcsin)) > 15) {
            if(arcsin >= 0 && arccos >= 0) {
                up = true
            } else {
                down = true
            }
        }
        
        if isUp(x: arcsin, y: arccos) {
            left = false
            right = false
            up = true
            down = false
        }
        
        if isDown(x: arcsin, y: arccos) {
            left = false
            right = false
            up = false
            down = true
        }
        
        if right {
            if up {
                direction = .upRight
            } else if down {
                direction = .downRight
            } else {
                direction = .right
            }
        } else if left {
            if up {
                direction = .upLeft
            } else if down {
                direction = .downLeft
            } else {
                direction = .left
            }
        } else if up {
            direction = .up
        } else {
            direction = .down
        }
        return direction
    }
    
    func considerDirection(_ touches: [CGPoint]) -> Direction {
        var directions = [Direction]()
        var previousTouch = CGPoint(x: 0, y: 0)
        touches.map { touchLocation -> CGPoint in
            if previousTouch.x == 0 && previousTouch.y == 0 {
                previousTouch = touchLocation
            } else {
                let diffVector = CGVector(dx: touchLocation.x - previousTouch.x, dy: touchLocation.y - previousTouch.y)
                let hypoteneuse = sqrt(Double(diffVector.dx * diffVector.dx) + Double(diffVector.dy * diffVector.dy))
                let opposite = Double(diffVector.dy)
                let adjacent = Double(diffVector.dx)
                let theta = (asin(opposite / hypoteneuse)).radiansToDegrees()
                let adjTheta = (acos(adjacent / hypoteneuse)).radiansToDegrees()
                let proposedDirection = getDirectionFromAngles(arcsin: adjTheta, arccos: theta)
                directions.append(proposedDirection)
                previousTouch = touchLocation
            }
            return touchLocation
        }
        var frequency: [Direction: Int] = [:]
        for direction in directions {
            frequency[direction] = (frequency[direction] ?? 0) + 1
        }
        let descending = frequency.sorted {
            $0.1 > $1.1
        }
        let directionToReturn = descending[descending.startIndex].0
        return directionToReturn
    }
}

class DrawingManager {
    var touchManager: [[CGPoint]] = [[CGPoint]]()
    var currentIndex = -1
    var coordinator = DirectionCoordinator()
    
    func addLocationToTouchManager(location: CGPoint) {
        if currentIndex < 0 {
            return
        }
        touchManager[currentIndex].append(location)
    }
    
    func startNewTouchArray(location: CGPoint) {
        currentIndex = currentIndex + 1
        touchManager.append([CGPoint]())
        touchManager[currentIndex].append(location)
    }
    
    func isDrawingARune() -> Runes {
        var drawingIsARune = Runes.none
        
        if coordinator.direction0 == .up {
            drawingIsARune = .vestri
        }
        
        return drawingIsARune
    }
    
    func checkTouches() -> Runes {
        switch(currentIndex) {
        case 0: coordinator.direction0 = coordinator.considerDirection(touchManager[currentIndex])
            break
        case 1: coordinator.direction1 = coordinator.considerDirection(touchManager[currentIndex])
            break
        case 2: coordinator.direction2 = coordinator.considerDirection(touchManager[currentIndex])
            break
        case 3: coordinator.direction3 = coordinator.considerDirection(touchManager[currentIndex])
            break
        default: break
        }
        return isDrawingARune()
    }
    
    func reset() {
        coordinator.reset()
        touchManager = [[CGPoint]]()
        currentIndex = -1
    }
}

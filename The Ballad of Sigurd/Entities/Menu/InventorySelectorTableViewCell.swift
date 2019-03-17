//
//  InventorySelectorTableViewCell.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/15/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import UIKit
import PlanetNineGateway

class InventorySelectorTableViewCell: UITableViewCell {
    
    var nineumImageView = UIImageView(image: UIImage(named: "Nineum7_Small"))
    var nineumTitle = UILabel(frame: CGRect(x: 65, y: 10, width: 164, height: 15))
    var statExplainer = UILabel(frame: CGRect(x: 65, y: 24, width: 164, height: 15))
    
    func setInventoryItemForCell(inventoryItem: InventoryItem) {
        
        self.backgroundColor = UIColor.clear
        
        guard let ubuntuFont = UIFont(name: "Ubuntu-Medium", size: 10) else {
            fatalError("""
        Failed to load the "Ubuntu-Medium" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        
        guard let orbitronFont = UIFont(name: "Orbitron-Bold", size: 12) else {
            fatalError("""
        Failed to load the "Orbitron-Bold" font. Make sure the font file is included in the project and the font name is spelled correctly
        """
            )
        }
        
        let nineum = inventoryItem.nineum!
        
        switch nineum.rarity {
        case .common:
            nineumImageView.image = UIImage(named: "Nineum1_Small")
        case .nine:
            nineumImageView.image = UIImage(named: "Nineum2_Small")
        case .uncommon:
            nineumImageView.image = UIImage(named: "Nineum3_Small")
        case .rare:
            nineumImageView.image = UIImage(named: "Nineum4_Small")
        case .epic:
            nineumImageView.image = UIImage(named: "Nineum5_Small")
        case .legendary:
            nineumImageView.image = UIImage(named: "Nineum6_Small")
        case .mythical:
            nineumImageView.image = UIImage(named: "Nineum7_Small")
        }
        
        nineumImageView.frame = CGRect(x: 18, y: 4, width: 40, height: 40)
        nineumTitle.text = inventoryItem.toString()
        nineumTitle.font = orbitronFont
        nineumTitle.textColor = UIColor.PlanetNineColors.secondary
        
        let stat = inventoryItem.stat.rawValue
        let boost = inventoryItem.statBoost
        
        statExplainer.text = "\(stat) +\(boost)"
        statExplainer.font = ubuntuFont
        statExplainer.textColor = UIColor.white
        
        self.addSubview(nineumImageView)
        self.addSubview(nineumTitle)
        self.addSubview(statExplainer)
    }
}

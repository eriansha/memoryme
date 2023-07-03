//
//  ItemNode.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/06/23.
//

import SpriteKit

class ItemNode: SKSpriteNode {
    var identifier: ItemIdentifier?
    
    var textures: [ItemTextureType: SKTexture]?
    
    var textureType: ItemTextureType? {
        didSet {
            guard let textureType, let newTexture = textures?[textureType] else { return }
            run(SKAction.setTexture(newTexture, resize: true))
        }
    }
    
    var bubbleDialog: InteractableItem?
    
    var isShowBubble: Bool = false {
        didSet {
            animateBubble(stop: !isShowBubble)
        }
    }
    
    func createInteractableItem(in scene: SKScene, withTextureType textureType: ItemTextureType?) -> InteractableItem {
        guard let identifier else { fatalError(.errorIdentifierNotFound) }
        let textures = identifier.getTextures()
        return InteractableItem(withNode: self, textures: textures)
    }
    
    private func animateBubble(stop: Bool = false) {
        if let component = bubbleDialog?.component(ofType: AnimationComponent.self) as? AnimationComponent {
            bubbleDialog?.node?.zPosition = 20
            if !stop {
                bubbleDialog?.node?.alpha = 1
                let atlasName = TextureResources.bubbleAtlasStatic
                component.animate(withTextures: atlasName.getAllTexturesFromAtlas(), withKey: "animateBubble")
            } else {
                bubbleDialog?.node?.alpha = 0
                component.removeAnimation()
            }
        }
    }
}
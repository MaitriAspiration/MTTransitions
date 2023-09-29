//
//  MTYAxisTranslationTransition.swift
//  MTTransitions
//
//  Created by Nazmul on 04/08/2022.
//

import Foundation
//MTFadeInTranslationTransitionTranslationTransition.swift
public class MTPerlinSwipeTransition: MTTransition {
    
    public var width: Float = 1.0
    public var transitionDuration: Float = 5
    public var scaleX: Float = 50
    public var scaleY: Float = 50

    override var fragmentName: String {
        return "PerlinSwipeFragment"
    }
    
    override var parameters: [String: Any] {
        return [
            "width": width,
            "transitionDuration": transitionDuration,
            "scaleX": scaleX,
            "scaleY": scaleY
        ]
    }
}

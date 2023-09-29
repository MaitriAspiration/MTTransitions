//
//  MTYAxisTranslationTransition.swift
//  MTTransitions
//
//  Created by Nazmul on 04/08/2022.
//

import Foundation
//MTFadeInTranslationTransitionTranslationTransition.swift
public class MTChiasmTransition: MTTransition {
    
    public var rgbSplit: Float = 0.05

    override var fragmentName: String {
        return "ChiasmFragment"
    }
    
    override var parameters: [String: Any] {
        return [
            "rgbSplit": rgbSplit
        ]
    }
}

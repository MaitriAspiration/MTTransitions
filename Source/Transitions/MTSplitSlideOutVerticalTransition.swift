//
//  MTDirectionalEasingTransition.swift
//  MTTransitions
//
//  Created by xu.shuifeng on 2021/2/22.
//

import MetalPetal

public class MTSplitSlideOutVerticalTransition: MTTransition {
    public var reverse = false

    override var fragmentName: String {
        return "SplitSlideOutVerticalFragment"
    }
    
    override var parameters: [String: Any] {
        return [
            "reverse": reverse
        ]
    }

}

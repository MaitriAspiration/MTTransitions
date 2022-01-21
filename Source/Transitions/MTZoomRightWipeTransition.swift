//
//  MTZoomRightWipeTransition.swift
//  MTTransitions
//
//  Created by iMac on 21/01/22.
//

public class MTZoomRightWipeTransition: MTTransition {
    
    public var zoomQuickness: Float = 0.8

    override var fragmentName: String {
        return "ZoomRightFragment"
    }

    override var parameters: [String: Any] {
        return [
            "zoomQuickness": zoomQuickness
        ]
    }
}

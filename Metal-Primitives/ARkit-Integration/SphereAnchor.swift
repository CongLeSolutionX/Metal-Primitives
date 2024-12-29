//
//  SphereAnchor.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/29/24.
//

import ARKit

class SphereAnchor: ARAnchor {
    override init(transform: simd_float4x4) {
        super.init(transform: transform)
    }
    
    required init(anchor: ARAnchor) {
        super.init(anchor: anchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

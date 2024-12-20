//
//  ShaderVertexFor3DView.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

import simd

/// The vertices being fed to the GPU.
struct ShaderVertexFor3DView {
  var position: SIMD4<Float>
  var color: SIMD4<Float>
}

struct ShaderUniformsFor3DView {
  var mvpMatrix: float4x4
}

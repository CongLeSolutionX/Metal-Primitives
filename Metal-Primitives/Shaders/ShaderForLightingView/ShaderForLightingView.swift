//
//  ShaderForLightingView.swift
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//
// Source: https://github.com/dehesa/sample-metal/blob/main/Metal%20By%20Example/Lighting/Shader.swift
//

import simd

/// The vertices being fed to the GPU.
struct ShaderVertexForLightingView {
  var position: SIMD4<Float>
  var normal: SIMD4<Float>
}

struct ShaderUniformsForLightingView {
  var modelViewProjectionMatrix: float4x4
  var modelViewMatrix: float4x4
  var normalMatrix: float3x3
}


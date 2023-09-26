// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 BarFragment(VertexOut vertexIn [[ stage_in ]],
                                          texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                                          texture2d<float, access::sample> toTexture [[ texture(1) ]],
                                          constant float & ratio [[ buffer(0) ]],
                                          constant float & progress [[ buffer(1) ]],
                                          sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float width = 0.08;
    
    float scaledProgress = -width + (progress * (1.0 + (width * 2.0)));
    
    float intensity = smoothstep(uv.x - width, uv.x, scaledProgress) - smoothstep(uv.x, uv.x + width, scaledProgress);
    
    float mixVal = step(scaledProgress, uv.x);
    
    return float4(intensity + ((1.0 - intensity) * mix(getToColor(uv, toTexture, ratio, _toR), getFromColor(uv, fromTexture, ratio, _fromR), mixVal)));

}

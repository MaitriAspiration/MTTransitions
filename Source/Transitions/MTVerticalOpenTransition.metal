// Author: Gaëtan Renaudeau
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 VerticalOpenFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float regress = 1.0 - progress;
    float s = 2.0 - abs((uv.x - 0.5) / (regress - 1.0)) - 2.0 * regress;
    
    return mix(getFromColor(uv, fromTexture, ratio, _fromR), getToColor(uv, toTexture, ratio, _toR),
      smoothstep(0.5, 0.0, s)
    );
}
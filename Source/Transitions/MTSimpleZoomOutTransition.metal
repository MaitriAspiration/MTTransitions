// Author: 0gust1
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float2 simple_zoom1(float2 uv, float amount) {
    return 0.5 + ((uv - 0.5) * (1.0-amount));
}

fragment float4 SimpleZoomOutFragment(VertexOut vertexIn [[ stage_in ]],
                                   texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                                   texture2d<float, access::sample> toTexture [[ texture(1) ]],
                                   constant float & zoomQuickness [[ buffer(0) ]],
                                   constant float & fade [[ buffer(1) ]],
                                   constant float & ratio [[ buffer(2) ]],
                                   constant float & progress [[ buffer(3) ]],
                                   sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float nQuick = clamp(zoomQuickness,0.2,1.0);
    
    return mix(getFromColor(uv, fromTexture, ratio, _fromR),
               getToColor(simple_zoom1(uv, 1.0-smoothstep(1.0-nQuick, 1.0, progress)), toTexture, ratio, _toR),
               fade ? smoothstep(1.0-nQuick, 1.0, progress) : (progress<1.0-nQuick?0.0:1.0)
               );
}

// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 DotFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float iTime = progress * 3.;
    
    float2 p = uv*2.0 - 1.0;
    float as = 1.;
    
    float3 col1 = getFromColor(uv, fromTexture, ratio, _fromR).rgb;
    float3 col2 = getToColor(uv, toTexture, ratio, _toR).rgb;
    
    float g = sin(iTime + 4.4)*2.2;
    
    float a = clamp(cos(p.x*200.0)-cos(p.y*200.0*as)+g+1.0,0.0,1.0);
    a = pow(a,10.0);
    float3 col = mix(col1,col2,a);
    // Output to screen
    return float4(col,1.0);
}

// Author: Gaëtan Renaudeau
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float parabola(float x) {
  float y = pow(sin(x * PI), 1.);
  return y;
}

fragment float4 DirectionalScaledFragment(VertexOut vertexIn [[ stage_in ]],
                                    texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                                    texture2d<float, access::sample> toTexture [[ texture(1) ]],
                                    constant float2 & direction [[ buffer(0) ]],
                                    constant float & scale [[ buffer(1) ]],
                                    constant float & ratio [[ buffer(2) ]],
                                    constant float & progress [[ buffer(3) ]],
                                    sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float2 easedProgress = pow(sin(progress  * PI / 2.), 3.);
    float2 p = uv + easedProgress * sign(direction);
    float2 f = fract(p);
    
    float2 s = 1. - (1. - (1. / scale)) * parabola(progress);
    f = (f - 0.5) * s  + 0.5;
    
    float4 mixer = step(0.0, p.y) * step(p.y, 1.0) * step(0.0, p.x) * step(p.x, 1.0);
    float4 col = mix(getFromColor(f, fromTexture, ratio, _fromR), getToColor(f, toTexture, ratio, _toR), mixer);
    
    float4 border = step(0., f.x) * step(0., (1. - f.x)) * step(0., f.y) * step(0., 1. - f.y);
    col *= border;

    return col;
}

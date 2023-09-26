// Author: gre
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 RotateScaleVanishFragment(VertexOut vertexIn [[ stage_in ]],
                               texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                               texture2d<float, access::sample> toTexture [[ texture(1) ]],
                               constant float & FadeInSecond [[ buffer(0) ]],
                               constant float & ReverseEffect [[ buffer(1) ]],
                               constant float & ReverseRotation [[ buffer(2) ]],
                               constant float & ratio [[ buffer(3) ]],
                               constant float & progress [[ buffer(4) ]],
                               sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float2 iResolution = float2(ratio, 1.0);
    float t = ReverseEffect ? 1.0 - progress : progress;
    float theta = ReverseRotation ? _TWOPI * t : -_TWOPI * t;
    float c1 = cos(theta);
    float s1 = sin(theta);
    float rad = max(0.00001, 1.0 - t);
    float xc1 = (uv.x - 0.5) * iResolution.x;
    float yc1 = (uv.y - 0.5) * iResolution.y;
    float xc2 = (xc1 * c1 - yc1 * s1) / rad;
    float yc2 = (xc1 * s1 + yc1 * c1) / rad;
    float2 uv2 = float2(xc2 + iResolution.x / 2.0, yc2 + iResolution.y / 2.0);
    float4 col3;
    float4 ColorTo = ReverseEffect ? getFromColor(uv, fromTexture, ratio, _fromR) : getToColor(uv, toTexture, ratio, _toR);

    if ((uv2.x >= 0.0) && (uv2.x <= iResolution.x) && (uv2.y >= 0.0) && (uv2.y <= iResolution.y))
        {
        uv2 /= iResolution;
        col3 = ReverseEffect ? getToColor(uv2, fromTexture, ratio, _fromR) : getFromColor(uv2, toTexture, ratio, _toR);
        }
    else { col3 = FadeInSecond ? float4(0.0, 0.0, 0.0, 1.0) : ColorTo; }
    return((1.0 - t) * col3 + t * ColorTo); // could have used mix
}

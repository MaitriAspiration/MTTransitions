// Author: gre
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float2 zoomInOut(float2 uv, float amount)
{
    return 0.5 + ((uv - 0.5) * (1.0-amount));
}

fragment float4 ZoomInOutFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    
    if(progress < 0.49) {
        return mix(
                   getFromColor(zoomInOut(uv, smoothstep(0.0, 1.0, progress * 2.0)), fromTexture, ratio, _fromR),
                   getToColor(uv, toTexture, ratio, _toR),
                   smoothstep(0.8, 1.0, progress)
                   );
    } else if (progress < 0.51) {
        return mix(
                   getFromColor(zoomInOut(uv, smoothstep(0.0, 1.0, progress * 2.0)), fromTexture, ratio, _fromR),
                   getToColor(zoomInOut(uv, smoothstep(0.0, 1.0, (1.0 - progress) * 2.0)), toTexture, ratio, _toR),
                   smoothstep(0.8, 1.0, progress)
                   );
        
    } else {
        return mix(
                   getToColor(zoomInOut(uv, smoothstep(0.0, 1.0, (1.0 - progress) * 2.0)), toTexture, ratio, _toR),
                   getFromColor(uv, fromTexture, ratio, _fromR),
                   smoothstep(0.8, 1.0, 1.0 - progress)
                   );
    }
}

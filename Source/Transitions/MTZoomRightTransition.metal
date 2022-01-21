//
//  MTZoomRightTransition.metal
//  MTTransitions
//
//  Created by iMac on 21/01/22.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float2 zoomCircle(float2 uv, float amount) {
    if(amount<0.5) {
        return 0.5 + ((uv - 0.5) * (1.0-amount));
    } else {
        return 0.5 + ((uv - 0.5) * (amount));
    }
}

fragment float4 ZoomRightFragment(VertexOut vertexIn [[ stage_in ]],
                                texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                                texture2d<float, access::sample> toTexture [[ texture(1) ]],
                                 constant float & zoomQuickness [[ buffer(0) ]],
                                constant float & ratio [[ buffer(1) ]],
                                constant float & progress [[ buffer(2) ]],
                                sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());

    float nQuick = clamp(zoomQuickness,0.0,0.5);

    if(progress<0.5){

        return mix(getFromColor(zoomCircle(uv, smoothstep(0.0, nQuick, progress)), fromTexture, ratio, _fromR),
                   getToColor(uv, toTexture, ratio, _toR),
                   step(0.5, progress)
                   );
    } else {

        float2 p=uv.xy/float2(1.0).xy;
        float4 d=getFromColor(p, fromTexture, ratio, _fromR);
        float4 e=getToColor(p, toTexture, ratio, _toR);
        float4 f= mix(d, e, step(0.0+p.x,(progress-0.5)*2.0));
        return f;
    }
}

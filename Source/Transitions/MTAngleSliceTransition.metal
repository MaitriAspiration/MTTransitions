// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float randomAngle (float2 st) {
    return fract(sin(dot(st.xy,
                         float2(12.9798,78.323)))*
        43758.5453234);
}

float2x2 rot2m(float a){

    float s = sin(a);
    float c = cos(a);
    
    return float2x2(c, -s, s, c);
}

float slices(float2 p, float count){
    const float rotAngle = 0.2;
    const float seed = 265.5;

    p *= rot2m(rotAngle);
    

    float x = p.x * count;
    
    float v = randomAngle( float2(floor(x)) + seed * count * 0.5 );
    
    return v;
}

float randomSlices(float2 p){
    const float sliceCount = 5.0;

    float s1 = 1.0, s2 = 0.0;
    
    for(float i = 1.0; i < sliceCount; ++i){
                
        float t = slices(p, 2.0 * i);
        
        s1 = min(s1, t);
        s2 = max(s2, t);
    }
        
    return (s1 + s2) * 0.5;
   
}

fragment float4 AngleSliceFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float v = randomSlices(uv);
    float b = smoothstep(0.0, v, sin(progress));
    float2 sp = float2(v, randomAngle(float2(v) ) ) * 0.5;
    
    float m1 = (b + 1.0);
    m1 = 1.0 / pow(m1, 0.25);
    
    float m2 = (2.0 - b);
    m2 = 1.0 / pow(m2, 0.25);
    
    float2 uv1 = (uv - sp) * m1 + sp;
    float2 uv2 = (uv - sp) * m2 + sp;
    
    float4 colA = getFromColor(fract(uv1), fromTexture, ratio, _fromR);
    float4 colB = getToColor(fract(uv2), toTexture, ratio, _toR);

    return mix(colA, colB, b);
}

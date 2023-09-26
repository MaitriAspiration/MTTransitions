// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float Hash( float2 p)
{
    float3 p2 = float3(p.xy,1.0);
    return fract(sin(dot(p2,float3(37.1,61.7, 12.4)))*3758.5453123);
}

float fiernoise(float2 p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    f *= f * (3.0-2.0*f);

    return mix(mix(Hash(i + float2(0.,0.)), Hash(i + float2(1.,0.)),f.x),
        mix(Hash(i + float2(0.,1.)), Hash(i + float2(1.,1.)),f.x),
        f.y);
}

float fbm(float2 p)
{
    float v = 0.0;
    v += fiernoise(p*1.)*.5;
    v += fiernoise(p*2.)*.25;
    v += fiernoise(p*4.)*.125;
    return v;
}

fragment float4 FireWipeFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float3 src = getFromColor(uv, fromTexture, ratio, _fromR).rgb;
    
    float3 tgt = getToColor(uv, toTexture, ratio, _toR).rgb;
    
    float3 col = src;
    
    uv.x -= 1.5;
    
    float ctime = progress * 1.5;
    
    // burn
    float d = uv.x+uv.y*0.5 + 0.5*fbm(uv*15.1) + ctime*1.3;
    if (d >0.35) col = clamp(col-(d-0.35)*10.,0.0,1.0);
    if (d >0.47) {
        if (d < 0.5 ) col += (d-0.4)*33.0*0.5*(0.0+fiernoise(100.*uv+float2(-ctime*2.,0.)))*float3(1.5,0.5,0.0);
        else col += tgt; }
    
    return float4(col, 1.0);
}

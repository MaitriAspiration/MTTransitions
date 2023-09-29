//
//  MTFadeInWipeUpTransition.metal
//  MTTransitions
//
//  Created by Nazmul on 04/08/2022.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float2 rotateXAndScaled(float2 pos, float2 center, float theta, float scale) {
    pos -= center;
    pos = float2(dot(float2(cos(theta), sin(theta)), pos), dot(float2(-sin(theta), cos(theta)), pos));
    pos *= scale;
    pos += center;
    return pos;
}

float and_(float x, float y) {
    if(x > ESP && y > ESP)
        return 1.0;
    else
        return 0.0;
}
float xor_(float x, float y) {
    if(abs(x - y) > ESP)
        return 1.0;
    else
        return 0.0;
}

float or_(float x, float y) {
    if(x < ESP && y < ESP)
        return 0.;
    else
        return 1.0;
}
float not_(float x) {
    return 1.0 - x;
}

float2 comb(float2 texCoord, float2 grid) {
    float2 posLocal = fract(texCoord * grid);
    posLocal -= 0.5;
    float lineWidth = 0.1;
    float scaleX = sqrt(3.);
    posLocal.x *= scaleX;
    float2 posLocal60 = rotateXAndScaled(posLocal, float2(0), PI / 3., 1.);
    float2 posLocal120 = rotateXAndScaled(posLocal, float2(0), 2. * PI / 3., 1.);
    float k = 1. / ((1. - lineWidth) / 2.);
    float v1 = floor(abs(posLocal.y) * k);
    float v2 = floor(abs(posLocal60.y) * k);
    float v3 = floor(abs(posLocal120.y) * k);
    float k1 = 1.0 / (0.5 + lineWidth / 2.0);
    float v4 = floor(abs(posLocal.y) * k1);
    float v5 = floor(abs(posLocal60.y) * k1);
    float v6 = floor(abs(posLocal120.y) * k1);
    float k2 = 1.0 / (lineWidth / 2.0);
    float v7 = floor(abs(posLocal.y) * k2);
    float v8 = xor_(or_(or_(v1, v2), v3), or_(or_(v4, v5), v6));
    float v9 = or_(not_(or_(or_(v4, v5), v6)), v7);
    float patternColor = and_(v9, not_(v8));
    return float2(patternColor, or_(or_(v1, v2), v3));
}
float combNum(float2 pattern, float2 pos, float2 grid) {
    float2 gridNum = floor(pos * grid), gridLoc = floor(fract(pos * grid) - 0.5);
    float num = (gridNum.x) * (grid.y * 2.0 + 1.0);
    num += (1.0 - pattern.y) * (grid.y + 1.0 + gridNum.y + 1.0);
    num += (pattern.y) * ((2.0 * gridLoc.x + 2.0) * grid.y + 1.0 + gridLoc.x + 1.0 + gridLoc.y + gridNum.y);
    return num;
}
float random(float x) {
    return fract(sin(x * 23.371531) * 15812.1231 + cos(x * 65.76) * 89.123);
}

float4 honeyComb(float2 texCoord) {
}

fragment float4 HoneyCombFragment(VertexOut vertexIn [[ stage_in ]],
                               texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                               texture2d<float, access::sample> toTexture [[ texture(1) ]],
                               constant float & rgbSplit [[ buffer(0) ]],
                               constant float & ratio [[ buffer(1) ]],
                               constant float & progress [[ buffer(2) ]],
                               
                               sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float2 texCoord = uv;
    
    float ratio1 = progress;
    float rTime = 0.8;
    float u_ratio = clamp(ratio1 / rTime, 0.0, 1.0);
    float2 grid = float2(10, 10);
    float2 center = float2(0.5, 0.5);
    float theta = u_ratio * PI / 2.0;
    float2 pos1 = rotateXAndScaled(texCoord, center, theta, 1.0 - 0.8 * u_ratio);
    float2 pos2 = rotateXAndScaled(texCoord, center, -PI / 2.0 + theta, 6.0 - 5.0 * u_ratio);
    float4 texColor1 = float4(0.0), texColor2 = float4(0.0);
    if(pos1.x > 0.0 && pos1.x < 1.0 && pos1.y > 0.0 && pos1.y < 1.0) {
        texColor1 = getFromColor(pos1, fromTexture, ratio, _fromR);
    }
    if(pos2.x > 0.0 && pos2.x < 1.0 && pos2.y > 0.0 && pos2.y < 1.0) {
        texColor2 = getToColor(pos2, toTexture, ratio, _toR);
    }
    float2 pattern1 = comb(pos1, grid);
    float2 pattern2 = comb(pos2, grid);
    float num1 = combNum(pattern1, pos1, grid);
    float num2 = combNum(pattern2, pos2, grid);
    float r1 = random(num1), r2 = random(num2);
    float alpha1 = floor(u_ratio - r1 + 1.0), alpha2 = floor(u_ratio - r2 + 1.0);
    float4 colo2 = pattern2.x * alpha2 * texColor2, colo1 = pattern1.x * (1.0 - alpha1) * texColor1;
    float4 color3 = mix(colo1, colo2, max(alpha1, 1.0 - pattern1.x));
    float k = -4.0, alpha3 = k * (texCoord.x - 1.0) + 1.0 + (ratio1 - rTime) / (1.0 - rTime) * (-1.0 + k);
    return mix(texColor2, color3, clamp(alpha3, 0.0, 1.0));

}

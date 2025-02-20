shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_disabled,diffuse_burley,specular_schlick_ggx;
uniform sampler2D source_texture_mask : source_color;
uniform sampler2D source_texture_black : source_color;
uniform sampler2D source_texture_red : source_color;
uniform sampler2D source_texture_green : source_color;
uniform sampler2D source_texture_blue : source_color;

uniform float Roughness = 1.0;
uniform float Normal = 1.0;
uniform float Normal_Deph = 1.0;
uniform float Normal_blue = 3.68;


uniform sampler2D normal_black : source_color;
uniform sampler2D roughness_black : source_color;
uniform sampler2D normal_red : source_color;
uniform sampler2D roughness_red : source_color;
uniform sampler2D normal_green : source_color;
uniform sampler2D roughness_green : source_color;
uniform sampler2D normal_blue : source_color;
uniform sampler2D roughness_blue : source_color;

uniform float uv_blk_x : hint_range(1.0, 2380.0, 1.0) = 1.0;
uniform float uv_blk_y : hint_range(1.0, 2380.0, 1.0) = 1.0;
uniform float uv_r_x : hint_range(1.0, 2380.0, 1.0) = 1.0;
uniform float uv_r_y : hint_range(1.0, 2380.0, 1.0) = 1.0;
uniform float uv_g_x : hint_range(1.0, 2380.0, 1.0) = 1.0;
uniform float uv_g_y : hint_range(1.0, 2380.0, 1.0) = 1.0;
uniform float uv_b_x : hint_range(1.0, 2380.0, 1.0) = 1.0;
uniform float uv_b_y : hint_range(1.0, 2380.0, 1.0) = 1.0;

uniform float cubic_a = 1.0;
uniform float cubic_b = 10.0;


vec4 hash4( vec2 p ) { return fract(sin(vec4( 1.0+dot(p,vec2(37.0,17.0)),
                                              2.0+dot(p,vec2(11.0,47.0)),
                                              3.0+dot(p,vec2(41.0,29.0)),
                                              4.0+dot(p,vec2(23.0,31.0))))*103.0); }
vec2 scale(vec2 uv, float x, float y)
{
	mat2 scale = mat2(vec2(x, 0.0), vec2(0.0, y));

	uv -= 0.5;
	uv = uv * scale;
	uv += 0.5;
	return uv;
}
vec4 textureNoTile(sampler2D samp, in vec2 uv){
		vec2 iuv = floor( uv );
		vec2 fuv = fract( uv );

	    vec4 ofa = hash4( iuv + vec2(0.0,0.0) );
	    vec4 ofb = hash4( iuv + vec2(1.0,0.0) );
	    vec4 ofc = hash4( iuv + vec2(0.0,1.0) );
	    vec4 ofd = hash4( iuv + vec2(1.0,1.0) );

	    vec2 ddx = dFdx( uv );
	    vec2 ddy = dFdy( uv );

	    // transform per-tile uvs
	    ofa.zw = sign(ofa.zw-0.5);
	    ofb.zw = sign(ofb.zw-0.5);
	    ofc.zw = sign(ofc.zw-0.5);
	    ofd.zw = sign(ofd.zw-0.5);

	    // uv's, and derivarives (for correct mipmapping)
	    vec2 uva = uv*ofa.zw + ofa.xy; vec2 ddxa = ddx*ofa.zw; vec2 ddya = ddy*ofa.zw;
	    vec2 uvb = uv*ofb.zw + ofb.xy; vec2 ddxb = ddx*ofb.zw; vec2 ddyb = ddy*ofb.zw;
	    vec2 uvc = uv*ofc.zw + ofc.xy; vec2 ddxc = ddx*ofc.zw; vec2 ddyc = ddy*ofc.zw;
	    vec2 uvd = uv*ofd.zw + ofd.xy; vec2 ddxd = ddx*ofd.zw; vec2 ddyd = ddy*ofd.zw;

	    // fetch and blend
	    vec2 b = smoothstep((cubic_a/100.0),(cubic_b/100.0),fuv);

	    return mix( mix( textureGrad( samp, uva, ddxa, ddya ),
	                     textureGrad( samp, uvb, ddxb, ddyb ), b.x ),
	                mix( textureGrad( samp, uvc, ddxc, ddyc ),
	                     textureGrad( samp, uvd, ddxd, ddyd ), b.x), b.y);
}

void fragment() {
vec2 uv_blk = scale(UV, uv_blk_x, uv_blk_y);
vec2 uv_r = scale(UV, uv_r_x, uv_r_y);
vec2 uv_g = scale(UV, uv_g_x, uv_g_y);
vec2 uv_b = scale(UV, uv_b_x, uv_b_y);


vec2 UV_Scaled = UV;

// texture_rgbmask UV is not scaled.
vec3 texture_rgbmask= texture(source_texture_mask, UV).rgb; 
vec3 texture_black 	= vec3(0.0);

vec3 norm_blk = textureNoTile(normal_black, uv_blk).rgb;
vec3 roughness_blk = textureNoTile(roughness_black, uv_blk).rgb;
vec3 norm_red = textureNoTile(normal_red, uv_r).rgb;
vec3 rough_red = textureNoTile(roughness_red, uv_r).rgb;
vec3 norm_green = textureNoTile(normal_green, uv_g).rgb;
vec3 rough_green = textureNoTile(roughness_green, uv_g).rgb;
vec3 norm_blue = textureNoTile(normal_blue, uv_b).rgb*Normal_blue;
vec3 rough_blue = textureNoTile(roughness_blue, uv_b).rgb;

vec3 texture_red 	= vec3(0.0);
vec3 texture_green 	= vec3(0.0);
vec3 texture_blue 	= vec3(0.0);

texture_black 	= textureNoTile(source_texture_black, uv_blk).rgb;
texture_red 	= textureNoTile(source_texture_red, uv_r).rgb;
texture_green 	= textureNoTile(source_texture_green, uv_g).rgb;
texture_blue 	= textureNoTile(source_texture_blue, uv_b).rgb;

float summed_texture_channels = (
	texture_rgbmask.r + 
	texture_rgbmask.g + 
	texture_rgbmask.b);

vec3 mixed_terrain = clamp(
		(	texture_rgbmask.r * texture_red +
			texture_rgbmask.g * texture_green +
			texture_rgbmask.b * texture_blue) /
			summed_texture_channels,
			vec3(0.0), vec3(1.0) // Clamp min, max values.
			);

ALBEDO = mix(mixed_terrain,texture_black,1.0 - summed_texture_channels);

vec3 mixed_normals = clamp(
		(	texture_rgbmask.r * norm_red +
			texture_rgbmask.g * norm_green +
			texture_rgbmask.b * norm_blue) /
			summed_texture_channels,
			vec3(0.0), vec3(1.0) // Clamp min, max values.
			);
vec3 mixed_roughness = clamp(
		(	texture_rgbmask.r * rough_red +
			texture_rgbmask.g * rough_green +
			texture_rgbmask.b * rough_blue) /
			summed_texture_channels,
			vec3(0.0), vec3(1.0) // Clamp min, max values.
			);


NORMAL_MAP = mix(mixed_normals,norm_blk,1.0 - summed_texture_channels)*vec3(1.0);
NORMAL *= Normal;
ROUGHNESS = mix(mixed_roughness.r,roughness_blk.r,1.0 - summed_texture_channels);
ROUGHNESS *= Roughness;
ROUGHNESS -= 0.699999999;


NORMAL_MAP_DEPTH = Normal_Deph;
SPECULAR = 0.08;





} // Fragment end
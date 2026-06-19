shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float pixel_size : hint_range(1.0, 64.0, 1.0) = 8.0;

void fragment() {
    vec2 block = max(pixel_size, 1.0) * SCREEN_PIXEL_SIZE;
    vec2 grid = floor(SCREEN_UV / block) * block;

    // Use texelFetch for hard nearest-neighbor, no AA whatsoever
    ivec2 texel_coord = ivec2(grid / SCREEN_PIXEL_SIZE);
    COLOR = texelFetch(screen_texture, texel_coord, 0);
}
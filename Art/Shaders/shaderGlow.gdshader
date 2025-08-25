shader_type canvas_item;
// no blend_add, use default alpha blending

uniform vec4 glow_color : source_color = vec4(1.0, 0.9, 0.5, 1.0);
uniform float glow_intensity : hint_range(0.0, 5.0) = 1.5;
uniform float glow_distance : hint_range(0.0, 20.0) = 5.0;
uniform float blend_amount : hint_range(0.0, 1.0) = 0.5;
uniform float pulse_speed : hint_range(0.0, 10.0) = 1.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    float alpha = tex.a;

    // --- Check nearby pixels for edges to extend glow ---
    float edge = alpha;
    if (alpha <= 0.0) {
        vec2 texel = SCREEN_PIXEL_SIZE * glow_distance;

        // sample 4-neighbour pixels
        edge += texture(TEXTURE, UV + vec2(texel.x, 0.0)).a;
        edge += texture(TEXTURE, UV - vec2(texel.x, 0.0)).a;
        edge += texture(TEXTURE, UV + vec2(0.0, texel.y)).a;
        edge += texture(TEXTURE, UV - vec2(0.0, texel.y)).a;

        edge *= 0.25; // average neighbours
    }

    // --- Glow strength ---
    float pulse = 1.0 + 0.2 * sin(TIME * pulse_speed);
    float glow_strength = clamp(edge * glow_intensity * pulse, 0.0, 1.0);

    vec4 glow = glow_color * glow_strength;

    // --- Final mix ---
    // blend_amount = 0 → just tex
    // blend_amount = 1 → tex + glow
    COLOR = mix(tex, tex + glow, blend_amount);

    // preserve alpha from sprite
    COLOR.a = tex.a;
}

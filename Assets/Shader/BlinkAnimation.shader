Shader "Custom/BlinkAnimation" {
  Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Brightness ( "Brightness", Range(1, 10)) = 1
        _Speed ( "Speed", Range(1, 10)) = 1
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200
        
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        float _Brightness;
        float _Speed;

        struct Input {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D (_MainTex, IN.uv_MainTex );
            if( _Speed > 0 && _Speed < 3 )
                c *=  ( abs( sin(_Time.x) ) * 0.5f) * _Brightness;
            else if ( _Speed > 3 && _Speed < 6 )
                c *=  ( abs( sin(_Time.y) ) * 0.5f) * _Brightness;
            else if ( _Speed > 6 && _Speed < 8 )
                c *=  ( abs( sin(_Time.z) ) * 0.5f) * _Brightness;
            else
                c *=  ( abs( sin(_Time.w) ) * 0.5f) * _Brightness;
            o.Albedo    = c.rgb;
            o.Alpha     = c.a;
        }
        ENDCG
    } 
    FallBack "Diffuse"
}
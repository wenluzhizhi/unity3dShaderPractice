Shader "Custom/ShaderSnow" {
	properties{
	   _MainTex("Main Texture",2D)="white"{}
	   _SnowTexture("Snow Texture",2D)="white"{}
	   _Gloss("_Gloss",Range(0,2))=1
	}
	Subshader{
	   pass{

	       CGPROGRAM
	       #pragma vertex vert
	       #pragma fragment frag
	       #include "unitycg.cginc"

	       struct a2v{
	          float4 vertex:POSITION;
	          float4 texcoord:TEXCOORD;
	       };

	       struct v2f{
	          float4 pos:SV_POSITION;
	          float2 uv:TEXCOORD0;
	       };

	       sampler2D _CameraDepthNormalsTexture;
	       sampler2D _SnowTexture;
	       sampler2D _MainTex;
	       v2f vert(a2v v){
	          v2f o;
	          o.pos=mul(UNITY_MATRIX_MVP,v.vertex);
	          o.uv=v.texcoord.xy;
	          return o;
	       }
	       float _Gloss;
	       float4x4 _CameraToWorld;
	       fixed4 frag(v2f i):SV_Target{
	          fixed4 col=fixed4(1,1,1,1);
	          half3 normal2;
	          float depth;

	          i.uv.y=1-i.uv.y;
	          DecodeDepthNormal(tex2D(_CameraDepthNormalsTexture,i.uv),depth,normal2);

	          float2 uv2=i.uv;
	          uv2.x+=sin(_Time.x)*0.3;
	          float4 snowTexture=tex2D(_SnowTexture,uv2);

	          normal2=mul((float3x3)_CameraToWorld,normal2);
	          float g=normal2.g;

	          //depth=Linear01Depth(depth);

	           i.uv.y=1-i.uv.y;
	           g=g*_Gloss;
	           col=tex2D(_MainTex,i.uv)*(1-g)+snowTexture*g;
	          // col=col*g;
	          return col;
	       }

	       ENDCG
	   }
	}
}

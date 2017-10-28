Shader "Custom/StestShader1" {
	Properties{

	    _FogColor("Fog Color",Color)=(1,1,1,1)
	    _MainTex("MainText",2D)="white"{}
	    _Gloss("Gloss",Range(0.01,1))=0.2
	    _Noise("Noise",2D)="white"{}
	    _t("Rang ",Range(0,1))=0.3
	}
	SubShader{



	      Pass{

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unitycg.cginc"

            float _Gloss;
            fixed4 _FogColor;
            sampler2D _MainTex;
            sampler2D _CameraDepthTexture;
            sampler2D _Noise;
            float4 _Noise_ST;

            float _t;

            struct a2v{
               float4 vertex:POSITION;
               float4 texcoord:TEXCOORD;
            };

            struct v2f{
               float4 pos:SV_POSITION;
               float2 uv:TEXCOORD1;
               float2 uv3:TEXCOOR2;
            };


            v2f vert(a2v v){
               v2f o;
               o.pos=mul(UNITY_MATRIX_MVP,v.vertex);
               o.uv=v.texcoord.xy;
               o.uv3=v.texcoord.xy*_Noise_ST.xy+_Noise_ST.zw;
               return o;
            }


            fixed4 frag(v2f i):SV_Target{
               fixed4 col=fixed4(1,1,1,1);
               float2 uv2=i.uv;
               uv2.y=1-uv2.y;

               float depth=Linear01Depth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture,uv2));
               col=tex2D(_MainTex,i.uv);

               i.uv3.x+=_SinTime.y;
               float4 t2=tex2D(_Noise,i.uv3);

               _FogColor.r=t2.r*0.6+0.4;



               col=lerp(col,_FogColor,sqrt(depth)*_Gloss);
                
               return col;
            }


            ENDCG
	      }
	}
}

Shader "Custom/GaussBlur" {
	properties{
        _MainTex("MainTex",2D)="white"{}
        _BurnSize("Blur Size",Range(0,10))=1.0
    }
    SubShader{
        pass{
           CGPROGRAM
           #pragma vertex vert
           #pragma fragment frag
           #include "unitycg.cginc"

           float _BurnSize;
           sampler2D _MainTex;
           float4 _MainTex_ST;
           half4 _MainTex_TexelSize;
           struct a2v{
              float4 vertex:POSITION;
              float4 texcoord:TEXCOORD;
           };


           struct v2f{
               float4 pos:SV_POSITION;
               float2 uv:TEXCOORD0;
           };

           v2f vert(a2v v){
              v2f o;
              o.pos=mul(UNITY_MATRIX_MVP,v.vertex);
              o.uv=_MainTex_ST.xy*v.texcoord.xy+_MainTex_ST.zw;
              return o;
           }

           fixed4 frag(v2f i):SV_Target{
             fixed4 col;

             col=tex2D(_MainTex,i.uv);

             half2 newUV=i.uv;

             half2 newUV_X_L2=newUV-float2(_MainTex_TexelSize.x*2,0.0)*_BurnSize;
             half2 newUV_X_L1=newUV-float2(_MainTex_TexelSize.x*1,0.0)*_BurnSize;

             half2 newUV_X_R2=newUV+float2(_MainTex_TexelSize.x*2,0.0)*_BurnSize;
             half2 newUV_X_R1=newUV+float2(_MainTex_TexelSize.x*1,0.0)*_BurnSize;


             half2 newUV_Y_D2=newUV-float2(0,_MainTex_TexelSize.x*2)*_BurnSize;
             half2 newUV_Y_D1=newUV-float2(0,_MainTex_TexelSize.x*1)*_BurnSize;

             half2 newUV_Y_U2=newUV+float2(0,_MainTex_TexelSize.x*2)*_BurnSize;
             half2 newUV_Y_U1=newUV+float2(0,_MainTex_TexelSize.x*1)*_BurnSize;


             float weight[3]={0.4026,0.2442,0.0545};

             col.rgb=col.rgb*weight[0]+(tex2D(_MainTex,newUV_X_L1)+tex2D(_MainTex,newUV_X_R1)).rgb*weight[1]+(tex2D(_MainTex,newUV_X_L2)+tex2D(_MainTex,newUV_X_R2)).rgb*weight[2];


             col.rgb+=(tex2D(_MainTex,newUV_Y_U1)+tex2D(_MainTex,newUV_Y_D1)).rgb*weight[1]+(tex2D(_MainTex,newUV_Y_U2)+tex2D(_MainTex,newUV_Y_U2)).rgb*weight[2];

             return col*0.7;
           }


           ENDCG
        }
    }

}

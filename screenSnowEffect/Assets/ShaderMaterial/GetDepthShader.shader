Shader "Custom/GetDepthShader" {
	Properties{

	   
	}
	Subshader{

	 Tags{"RenderType"="Opaque"}
	   pass{

           LOD 200

	      
	       CGPROGRAM
	       #pragma vertex vert
	       #pragma fragment frag
	       #include "unitycg.cginc"

	       struct a2v{
	         float4 vertex:POSITION;
	       };

	       struct v2f{
	          float4 pos:SV_POSITION;
	          float2 depth:TEXCOORD1;
	       };


	       v2f vert(a2v v){
	          v2f o;
	          o.pos=mul(UNITY_MATRIX_MVP,v.vertex);
	          o.depth=o.pos.zw;
	          return o;
	       }

	       fixed4 frag(v2f i):SV_Target{
	          fixed4 col=fixed4(1,1,1,1);
	          float d=i.depth.x/i.depth.y;
	          //col=EncodeFloatRGBA(d);
	          return d;
	       }


	       ENDCG
	   }
	}
}

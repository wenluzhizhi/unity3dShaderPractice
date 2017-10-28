Shader "Custom/ShowShadow" {
	Properties{

	    _MainTex("",2D)="white"{}

	    _Color("Main Color",Color)=(1,1,1,1)
	}

	Subshader{
	  tags{"RenderTeype"="Opaque"}
	  LOD 200

	  CGPROGRAM
	  #pragma surface surf Standard fullforwardshadows
	  #pragma target 3.0

	  float4x4 _ProjectLit;
	  fixed4 _Color;

	  sampler2D _DepthCameraTexture;

	  struct Input{
	     float3 worldPos;
	  };

	  void surf(Input IN,inout SurfaceOutputStandard o){

	     float3 posInLight = mul(_ProjectLit, float4(IN.worldPos, 1)).xyz;


	  
	     float d=tex2D(_DepthCameraTexture,posInLight.xy).r;

	     float s=posInLight.z<d?1:0.1;

	     if(s<0.4){
	        o.Albedo=fixed4(1,0,0,1);
	     }
	     else{

	     o.Albedo=_Color*s;
	     }
	  }


	  ENDCG
	}
}

using UnityEngine;
using System.Collections;

public class CameraRender : MonoBehaviour {


	public Material ma;
	void Start () {
		Camera.main.depthTextureMode = DepthTextureMode.DepthNormals;
	}


	void Update () {

	}


	//[ImageEffectOpaque]
	void OnRenderImage(RenderTexture src,RenderTexture dest)
	{
		ma.SetMatrix ("_CameraToWorld",Camera.main.cameraToWorldMatrix);
		Graphics.Blit (src, dest, ma);
	}

	public void OnClickSliderChange(float value)
	{
		ma.SetFloat ("_Gloss",value);
	}
}

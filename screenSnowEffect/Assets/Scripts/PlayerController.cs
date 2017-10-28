using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class PlayerController : MonoBehaviour {


	public FlipPage fp;
	public Slider slider;
	public Transform BillBoard;
	public Text InfoTxt;

	public CameraRender cameraRender;
	void Start () {
		InfoTxt.text = "通过 WSDA或者方向键可以控制相机移动";
	}
	

	void Update () {

		if (Input.GetKey (KeyCode.UpArrow)||Input.GetKey(KeyCode.W)) {
			goFront (1);
		}
		if (Input.GetKey (KeyCode.DownArrow)||Input.GetKey(KeyCode.S)) {
			goFront (-1);
		}
		if (Input.GetKey (KeyCode.RightArrow)||Input.GetKey(KeyCode.D)) {

			turnRight (1);
		}

		if (Input.GetKey (KeyCode.LeftArrow)||Input.GetKey(KeyCode.A)) {
			turnRight (-1);
		}
	
	}


	private void goFront(int k){
		transform.Translate (transform.forward*k,Space.World);
	}

	private void turnRight(int k){
		transform.Rotate (transform.up * k,Space.World);
	}




	public void OnClickLookWater(){

		InfoTxt.text = "动态雾,拖动滑块可以动态调整雾的浓度";

		cameraRender.enabled = !cameraRender.enabled;
		slider.gameObject.SetActive (cameraRender.enabled);
		if (cameraRender.enabled) {
			slider.gameObject.SetActive (true);
		}

	}

	public void OnClickFlipPage(){
		InfoTxt.text = "基于ShadowMap实现阴影技术,在Plane上的红色阴影为自己实现，地形上的为系统阴影";
		transform.position = new Vector3 (313,14,345);
		transform.rotation = Quaternion.Euler (0,277,0);
		fp.FlipPage2 ();
	}


	public void OnClickCurve(){
		InfoTxt.text = "积雪特效,拖动滑块可以动态调整积雪的浓度";
		cameraRender.enabled = !cameraRender.enabled;
		slider.gameObject.SetActive (cameraRender.enabled);
		if (cameraRender.enabled) {
			slider.gameObject.SetActive (true);
		}


	}

	public void OnClickBillBoard(){

		//transform.position = new Vector3 (306,13,275);
		//transform.rotation = Quaternion.Euler (0,100,0);
		InfoTxt.text = "摄像机在移动，但是广告牌始终朝向视角方向";
		StartCoroutine(roundBillBoard());
	}

	public IEnumerator roundBillBoard(){
		for (int i = 0; i < 360; i++) {
		 transform.LookAt (BillBoard,Vector3.up);
			transform.RotateAround (BillBoard.transform.position, Vector3.up, 1);
			yield return   new WaitForSeconds (0.04f);
		}
	}


	public void OnClickGaussBlur(){
		

		if (slider.gameObject.activeInHierarchy) {
			InfoTxt.text = "拖动滑条可以改变高斯模糊的程度";
		}
	}



}

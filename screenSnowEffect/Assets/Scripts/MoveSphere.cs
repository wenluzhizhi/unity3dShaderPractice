using UnityEngine;
using System.Collections;

public class MoveSphere : MonoBehaviour {


	public Vector3 pos1;
	public Vector3 pos2;

	public float t=4;
	void Start () {
		InvokeRepeating ("swapPos", 1, t );
	}

	private void  swapPos(){
		Vector3 v;
		v = pos1;
		pos1 = pos2;
		pos2 = v;
	}
	

	void Update () {
		transform.position = Vector3.Lerp( transform.position, pos1,Time.deltaTime );
		//temp+=Time.deltime;


	}
}

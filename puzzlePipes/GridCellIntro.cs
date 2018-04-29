using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridCellIntro : MonoBehaviour {

	public Transform finger;
	public Transform startPiece;
	Vector3 finishPosition;
	bool started;

	void Start() {
		// Check startPiece scale and store it
		//finishPosition = new Vector3()
	}

	void Update() {
		
	}

	void Check() {
		if(Input.touchCount > 0 && !started) {
			Touch touch = Input.GetTouch (0);
			if (touch.phase == TouchPhase.Began) {
				gameObject.SetActive (false);
				started = true;
				// Check scale here and if it equals start scale and finish position then set finger to active 
			}
		}
		// or maybe check it here
	}

	void OnTriggerEnter2D(Collider2D col) {
		if(col && col.tag != "Ball") {
			finger.gameObject.SetActive (true);
		}
	}

	// TODO figure out how to delay the activation of the finger until piece is set. (maybe have it check the scale of piece moved)
}

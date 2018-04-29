using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Finger : MonoBehaviour {

	bool hasStarted;

	void Update () {
		Check ();
	}
	void Check() {
		if(!hasStarted) {
			// figure out how to draw a line as the finger moves to it's position.
			if (Input.touchCount > 0) {
				Touch touch = Input.GetTouch (0);
				if (touch.phase == TouchPhase.Began) {
					gameObject.SetActive (false);
					hasStarted = true;
				}
			}
		}
	}
}

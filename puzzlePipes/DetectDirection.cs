using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectDirection : MonoBehaviour {

	private BoxCollider2D booster;
	private CircleCollider2D ballCol;

	void Start() {
		booster = transform.parent.GetComponent<BoxCollider2D> ();
		ballCol = GameObject.Find ("Ball").GetComponent<CircleCollider2D> ();
	}

	void OnTriggerEnter2D(Collider2D col) {
		if (col && col.tag == "Ball") {
			Physics2D.IgnoreCollision (ballCol, booster);
		}
	}


}

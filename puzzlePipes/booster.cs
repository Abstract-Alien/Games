using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Booster : MonoBehaviour {

	public float speed;
	public bool hasBoosted;
	Rigidbody2D ballRB;
	Vector2 direction;
	//CircleCollider2D ballCol;
	//BoxCollider2D directionCol;

	void Start() {
		ballRB = GameObject.Find ("Ball").GetComponent<Rigidbody2D>();
		//ballCol = ballRB.GetComponent<CircleCollider2D> ();
		//directionCol = this.GetComponentInChildren<BoxCollider2D> ();
	}

	void Update() {
	}

	void OnTriggerEnter2D(Collider2D col) {
		if (col && col.tag == "Ball" && !hasBoosted) {
			//Physics2D.IgnoreCollision (ballCol, directionCol);
			Vector2 ballPos = ballRB.position;
			Vector2 thisPos = this.transform.position;
			direction = thisPos - ballPos;
			direction.Normalize ();
			Boost (direction);
			Debug.Log ("Boosted");
			// Trigger animation which depletes the green arrow
			//hasBoosted = true;
		}
	}

	void Boost(Vector2 direction) {
		ballRB.AddRelativeForce (direction * speed, ForceMode2D.Impulse);
	}

}


// TODO Make the ball only able to boost in one direction

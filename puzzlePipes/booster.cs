using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Booster : MonoBehaviour {

	public float speed;
	public bool hasBoosted;
	Rigidbody2D ballRB;
	Vector2 direction;

	void Start() {
		ballRB = GameObject.Find ("Ball").GetComponent<Rigidbody2D>();
	}

	void Update() {
	}

	void OnTriggerEnter2D(Collider2D col) {
		if (col && col.tag == "Ball" && !hasBoosted) {
			Vector2 ballPos = ballRB.position;
			Vector2 thisPos = this.transform.position;
			direction = thisPos - ballPos;
			direction.Normalize ();
			Boost (direction);
			// Trigger animation which depletes the green arrow
			//hasBoosted = true;
		}
	}

	void Boost(Vector2 direction) {
		ballRB.AddRelativeForce (direction * speed, ForceMode2D.Impulse);
	}

}

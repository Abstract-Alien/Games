using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour {
	
	Rigidbody2D ballRB;

	public void Start() {
		ballRB = this.GetComponent<Rigidbody2D> ();
	}

	void OnTriggerEnter2D(Collider2D col) {
		if (col.tag == "Finish Hole") {
			ballRB.velocity = new Vector2 (0, 0);
			ballRB.freezeRotation = true;
			ballRB.isKinematic = true;
			// Add animation script to make it look like ball is falling in the hole
			// Make a panel pop up saying how many stars were collected and have buttons to either move on or go back to level select
			ScoreManager.instance.SetPickupsForLevel();
			UIManager.instance.OpenFinishPanel ();
		} else if (col.tag == "Pickup") { 
			// Trigger pickup animation
			ScoreManager.instance.IncreasePickups ();
			col.gameObject.SetActive (false);
			// Debug.Log (ScoreManager.instance.pickups);
		}
	}
}

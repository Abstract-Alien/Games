using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour {

	public static GameManager instance = null; 
	GameObject pickUp1;
	GameObject pickUp2;
	GameObject pickUp3;
	GameObject ball;
	Rigidbody2D ballRB;
	Vector2 ballStartPos;

	void Start() {
		if (instance != null) {
			Destroy (gameObject);
		} else {
			instance = this;
			//GameObject.DontDestroyOnLoad (gameObject);
		}
		ball = GameObject.Find ("Ball");
		ballRB = ball.GetComponent<Rigidbody2D> ();
		ballStartPos = ball.transform.position;
		pickUp1 = GameObject.Find ("Pickup1");
		pickUp2 = GameObject.Find ("Pickup2");
		pickUp3 = GameObject.Find ("Pickup3");
	}

	public void Play() {
		ballRB.freezeRotation = false;
		ballRB.isKinematic = false;
	}

	public void Reset() {
		ballRB.isKinematic = true;
		ballRB.freezeRotation = true;
		ballRB.velocity = new Vector2 (0, 0);
		ball.transform.position = ballStartPos;
		pickUp1.SetActive (true);
		pickUp2.SetActive (true);
		pickUp3.SetActive (true);
		ScoreManager.instance.ResetPickups ();
		UIManager.instance.CloseFinishPanel ();

		// Will have to change this once I get boosting working properly
		GameObject.Find ("Booster").GetComponent<Booster> ().hasBoosted = false;
		// Make function that animates ball into position, like dropping from above, call it here
	}

}

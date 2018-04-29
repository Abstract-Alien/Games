using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ScoreManager : MonoBehaviour {

	public static ScoreManager instance = null;
	public int pickups;
	public string sceneName;
	public int setPickups;

	// Use this for initialization
	void Start () {
		if (instance != null) {
			Destroy (gameObject);
		} else {
			instance = this;
			//GameObject.DontDestroyOnLoad (gameObject);
		}
		pickups = 0;
		sceneName = SceneManager.GetActiveScene ().name;
	}
	
	public void IncreasePickups() {
		pickups++;
	}

	public void ResetPickups() {
		pickups = 0;
	}

	public void SetPickupsForLevel() {
		// for each scene
		// 	if (pickups > setPickups) {
		// 		setPickups = pickups;
		//	}
		// once popup at end of level show, set the specific pickup score for this level
		// if a previous pickup score was earned, only update it if the current one is higher
	}
}

// Add pickup score to player prefs per level
// make a function to call pickup score for specific level

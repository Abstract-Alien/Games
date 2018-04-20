using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIManager : MonoBehaviour {

	public static UIManager instance;
	bool started;
	public GameObject startPanel;
	public GameObject finishPanel;

	void Start() {
		if (instance != null) {
			Destroy (gameObject);
		} else {
			instance = this;
			//GameObject.DontDestroyOnLoad (gameObject);
		}
		/*finishPanel = GameObject.Find ("Level Finish Panel");*/
	}

	public void StartMenu() {
		startPanel.SetActive (true);
	}

	public void ClosePanel(GameObject closePanel) {
		closePanel.SetActive (false);
	}

	public void WorldSelect(GameObject world) {
		world.SetActive (true);
	}

	public void OpenFinishPanel() {
		finishPanel.SetActive (true);
	}

	public void CloseFinishPanel() {
		finishPanel.SetActive (false);
	}
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManager : MonoBehaviour {

	public void LoadLevel(string name) {
		SceneManager.LoadScene (name);
	}

	public void QuitGame() {
		Application.Quit ();
	}

	public void LoadNextLevel() {
		SceneManager.LoadScene (SceneManager.sceneCount + 1);
	}

	/*
	 public void LoadWorldSelect() {
		SceneManager.LoadScene(Insert world select scene here);
	}


	*/

	public void ResetLevel() {
		GameManager.instance.Reset ();
		SceneManager.LoadScene (SceneManager.GetActiveScene().name);
		//GameManager.instance.ReloadLevel ();
	}
}


// FOR MENU

// TODO on title screen add a settings button and info button
// TODO in settings tab make music and sound effects able to toggle on and off
// TODO on title screen open up world selection after tapping the icon instead of just tapping the screen
// TODO make each world button open up a different panel with the corresponding levels
// TODO have a back button on all panels and keep the settings button stuck to the front
// TODO have a three star system for each level and show players progress on each one from level select screen
// TODO design each world panel to coincide with the theme of that world
// TODO make a nice transition animation when starting a level

// FOR LEVELS

// TODO create a start and finish tile
// have the ball drop into place at the start of the level and when level reset
// TODO have the ball drop through a hole once it reaches the finish tile
// be able to start the ball rolling by tapping on the start tile
// tapping on the start tile after the ball is rolling returns the ball to the start tile
// TODO once the ball reaches the finish tile, have it press a button or some sort of animation
// TODO once level is finished, show how many stars were collected and then proceed to the next level
// TODO create a sprite that determines if a tile is immovable
// TODO make a tutorial level that uses images and animations instead of words
// TODO create tiles that are able to rotate, ones that add velocity, other special tiles
// TODO have rotatable tiles rotate on tap, but not pick up right away
// TODO create the star objects players must collect 
// TODO make a button that resets the level
// TODO make a button to bring up settings and allow to go back to main menu
// TODO make a cool glow or light burst animation when the ball rolls into the finish hole (make it more satisfactory when the level is beaten)

// FOR SOUND

// TODO sound effects for tapping on menu buttons
// TODO sound effects for collecting the stars
// TODO a different type of sound effect for pressing a level button
// TODO a different sound effect for pressing the back button in the menu
// TODO sound effect for tapping the ball to start it rolling
// TODO different sound effect but similar to return ball to start
// TODO ball rolling sound effect
// TODO sound effect for picking up and dropping tiles
// TODO different sound effect for rotating tiles
// TODO sound effect for adding velocity to a ball
// TODO main menu music, music for different worlds, have music persist from level to level (keep music minimal and mellow)

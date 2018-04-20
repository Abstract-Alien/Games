using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridCell : MonoBehaviour {

	public bool hasChild;

	void Update () {
		if (this.transform.childCount == 0) {
			hasChild = false;
		} else {
			hasChild = true;
		}
	}

	void OnTriggerStay2D(Collider2D col) {
		if(col && !hasChild) {
			if (col.tag == "Draggable" || col.tag == "Start Piece" || col.tag == "Finish Piece") {
				col.gameObject.transform.parent = this.transform;
				hasChild = true;
			} else if (col && col.tag == "Draggable" && hasChild) {
				col.transform.parent = null;
			}
		}
	}

	void OnTriggerExit2D(Collider2D col) {
		if(col && col.tag == "Draggable") {
			col.gameObject.transform.parent = null;
			hasChild = false;
		}
	}
}

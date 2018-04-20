using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveManager : MonoBehaviour {
	
	Transform toDrag;
	Transform originalParent;
	Transform newParent;
	Vector3 targetPosition;
	Vector3 startSize;
	Vector3 pickUpSize;
	Vector2 piecePos;
	Vector2 offset;
	bool dragging;
	bool dropped;
	bool droppable = true;
	bool started;
	float speed = 2.5f;

	void Start() {
		startSize = new Vector3 (1f, 1f, 1f);
		pickUpSize = new Vector3 (1.15f, 1.15f, 1.15f);
	}

	void Update () {
		if (Input.touchCount != 0) {
			Play ();
		}
		if (dropped) {
			SmoothMove ();
		}
	}

	void Play() {
		for(int i =0; i < Input.touchCount; i++) {
			Touch touch = Input.GetTouch (0);
			if(touch.phase == TouchPhase.Began) {
				dropped = false;
				Vector2 pos = Camera.main.ScreenToWorldPoint(Input.GetTouch(0).position);
				RaycastHit2D hit = Physics2D.Raycast (pos, pos, 0.1f);
				if(hit && hit.collider.tag == "Draggable" && !started) {
					toDrag = hit.transform;
					piecePos = toDrag.position;
					originalParent = toDrag.parent;
					toDrag.localScale = pickUpSize; //new Vector3 (1.15f, 1.15f, 1.15f);
					toDrag.GetComponentInParent<SpriteRenderer> ().sortingOrder = 2;
					dragging = true;
					offset = toDrag.position - Camera.main.ScreenToWorldPoint(new Vector3(touch.position.x, touch.position.y, toDrag.position.z));
				}  else if (hit && hit.collider.tag == "Start Piece" && !started) {
					GameManager.instance.Play ();
					started = true;
				}  else if (hit && hit.collider.tag == "Start Piece" && started) {
					GameManager.instance.Reset ();
					started = false;
				}
			}

			if (dragging && touch.phase == TouchPhase.Moved) {
				toDrag.position = (Vector2)Camera.main.ScreenToWorldPoint(touch.position) + offset;
			if(toDrag.parent == null || toDrag.parent.childCount > 1) {
					droppable = false;
				} else if(toDrag.parent != null || toDrag.parent.childCount <= 1) {
					newParent = toDrag.parent;
					droppable = true;
				}
			}

			if (dragging && touch.phase == TouchPhase.Ended) {
				if (droppable) {
					dropped = true;
				} else if(!droppable){
					toDrag.parent = originalParent;
					dropped = true;
				}
				dragging = false;
			}
			// TODO smooth piece scaling when dropped **May need to figure out Lerp, movetowards wasn't working
		}
	}

	void SmoothMove() {
		if (dropped) {
			if (droppable) {
				targetPosition = newParent.position;
				toDrag.position = Vector3.MoveTowards (toDrag.position, newParent.position, speed * Time.deltaTime);
			} else {
				targetPosition = piecePos;
				toDrag.position = Vector3.MoveTowards (toDrag.position, piecePos, 10f * Time.deltaTime);
			}
		}
		if (toDrag.position == targetPosition) {
			toDrag.localScale = startSize; //new Vector3 (1f, 1f, 1f);
			//toDrag.localScale = Vector3.MoveTowards(pickUpSize, startSize, 10f * Time.deltaTime);
			toDrag.GetComponentInParent<SpriteRenderer> ().sortingOrder = 0;
		}
	}

}

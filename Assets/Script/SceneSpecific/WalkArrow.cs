using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WalkArrow : MonoBehaviour
{
    public Direction direction;
    public bool go = false;
    public Person person;
    static bool going = false;
    float minX;

    // Start is called before the first frame update
    void Start()
    {
        minX = transform.position.x;

        person = GameObject.Find("Person").GetComponent<Person>();

        if(gameObject.name[0] == 'L')
        {
            direction = Direction.LEFT;
        }
        else if(gameObject.name[0] == 'R')
        {
            direction = Direction.RIGHT;
        }
    }

    // Update is called once per frame
    void Update()
    {
        if(go)
        {
            switch(direction)
            {
                case Direction.LEFT:
                    person.walk = -1f;
                    break;
                case Direction.RIGHT:
                    person.walk = 1f;
                    break;
            }
        }
        else
        {
            if(!going)
                person.walk = 0;
        }
    }

    private void FixedUpdate()
    { 
        if(TransitionManager.instance.state == TransitionManager.State.OFF)
        {
            transform.parent = TransitionManager.instance.transform;
        }
        else
        {
            transform.parent = null;
        }
    }

    private void OnMouseDown()
    {
        go = true;
        going = true;
    }
    private void OnMouseUp()
    {
        go = false;
        going = false;
    }

    public enum Direction { RIGHT, LEFT };
}

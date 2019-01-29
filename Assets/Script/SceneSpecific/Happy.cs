using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Happy : MonoBehaviour
{
    public Vector3 startPos;
    public Vector3 goal;
    public bool complete = false;
    Vector3 offset;
    bool drag = false;

    public float waitTime;
    float completeTime = -1f;

    // Start is called before the first frame update
    void Start()
    {
        startPos = transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        if(complete == false)
        {
            if(drag)
            {
                transform.position = Camera.main.ScreenToWorldPoint(Input.mousePosition) - offset;
            }
            else
            {
                transform.position = Vector3.Lerp(transform.position, startPos, 0.1f);
            }
        }
        else
        {
            transform.position = Vector3.Lerp(transform.position, goal, 0.1f);
        }

        if(completeTime != -1f && completeTime + waitTime <= Time.time)
        {
            TransitionManager.instance.Go();
            Destroy(this);
        }
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        complete = true;
        completeTime = Time.time;
    }

    private void OnMouseDown()
    {
        drag = true;
        offset = Camera.main.ScreenToWorldPoint(Input.mousePosition) - transform.position;
    }
    private void OnMouseUp()
    {
        drag = false;
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sun : MonoBehaviour
{
    Vector3 startPos;
    Vector3 endPos = new Vector3(0, 2.48f, 0);
    Vector3 offset;
    bool drag = false;

    public float goalY, goalX;

    public bool complete = false;

    float completeTime = -1f;
    public float waitTime = 5f;

    // Start is called before the first frame update
    void Start()
    {
        startPos = transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        if (!complete)
        {
            if (drag)
            {
                transform.position = Camera.main.ScreenToWorldPoint(Input.mousePosition) + offset;
            }
            else
            {
                transform.position = Vector3.Lerp(transform.position, startPos, 0.1f);
            }

            if (transform.position.x > goalX && transform.position.y > goalY)
            {
                complete = true;
                completeTime = Time.time;
            }
        }
        else
        {
            transform.position = Vector3.Lerp(transform.position, endPos, 0.1f);
        }

        if(Time.time - waitTime > completeTime && completeTime != -1f)
        {
            TransitionManager.instance.Go();
            Destroy(this);
        }
    }

    private void OnMouseDown()
    {
        drag = true;
        offset = transform.position - Camera.main.ScreenToWorldPoint(Input.mousePosition);
    }
    private void OnMouseUp()
    {
        drag = false;
    }
}

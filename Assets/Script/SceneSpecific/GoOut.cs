using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoOut : MonoBehaviour
{
    Vector3 startPos;
    Vector3 endPos = new Vector3(0,0,0);
    float completeTime = -1f;
    public float waitTime;
    public float loadTime;
    bool complete = false;

    // Start is called before the first frame update
    void Start()
    {
        startPos = transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        if(complete)
        {
            transform.position = Vector3.Lerp(endPos, startPos, (completeTime + waitTime - Time.time) / waitTime);

            if (Time.time > completeTime + loadTime)
            {
                TransitionManager.instance.Go();
                Destroy(this);
            }
        }
    }

    private void OnMouseDown()
    {
        complete = true;
        completeTime = Time.time;

        Destroy(GameObject.Find("Today"));
        Destroy(GameObject.Find("I"));
        Destroy(GameObject.Find("Will"));
        Destroy(GameObject.Find("Sleep"));
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaybeAnotherTime : MonoBehaviour
{
    public float timeOnScreen = 5f;
    float startTime;

    // Start is called before the first frame update
    void Start()
    {
        startTime = Time.time;
    }

    // Update is called once per frame
    void Update()
    {
        if(Time.time > startTime + timeOnScreen)
        {
            TransitionManager.instance.Go();
            Destroy(this);
        }
    }
}

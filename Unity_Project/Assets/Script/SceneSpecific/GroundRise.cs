using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundRise : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(TransitionManager.instance.state == TransitionManager.State.OFF)
        {
            TransitionManager.instance.state = TransitionManager.State.OUT;
        }
    }
}

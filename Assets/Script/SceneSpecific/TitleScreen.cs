using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TitleScreen : MonoBehaviour
{
    TransitionManager transitionManager;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transitionManager = TransitionManager.instance;

        if (Input.GetKeyDown(KeyCode.Space))
            transitionManager.Go();
    }
}

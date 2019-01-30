using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraRatio : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        if(Camera.main.aspect == 16 / 10)
        {
            Camera.main.orthographicSize = 5.5f;
        }
        else if (Camera.main.aspect == 16 / 9)
        {
            Camera.main.orthographicSize = 5f;
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (Screen.width / Screen.height == 16 / 10)
        {
            Camera.main.orthographicSize = 5.5f;
        }
        else if (Screen.width / Screen.height == 16 / 9)
        {
            Camera.main.orthographicSize = 5f;
        }
    }
}

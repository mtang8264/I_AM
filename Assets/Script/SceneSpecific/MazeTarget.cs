using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MazeTarget : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        Debug.Log("Test");  
        if(collision.gameObject.layer == 8)
        {
            TransitionManager.instance.Go();
            Destroy(collision.gameObject.GetComponent<Ball>());
        }
    }
}

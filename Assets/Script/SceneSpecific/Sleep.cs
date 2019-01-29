using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sleep : MonoBehaviour
{
    public RuntimeAnimatorController controller;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Camera.main.gameObject.GetComponent<Animator>().enabled)
            if (Camera.main.gameObject.GetComponent<Animator>().GetComponent<Animator>().GetCurrentAnimatorStateInfo(0).IsName("Idle"))
            {
                Camera.main.GetComponent<Animator>().runtimeAnimatorController = null;
            }
    }

    private void OnMouseDown()
    {
        Camera.main.gameObject.GetComponent<Animator>().runtimeAnimatorController = controller;
    }
}

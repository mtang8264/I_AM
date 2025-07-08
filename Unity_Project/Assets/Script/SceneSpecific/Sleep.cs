using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sleep : MonoBehaviour
{
    public RuntimeAnimatorController controller;
    public List<SpriteRenderer> renderers;

    // Start is called before the first frame update
    void Start()
    {
        renderers.Add(GameObject.Find("Sleep").GetComponent<SpriteRenderer>());
        renderers.Add(GameObject.Find("Today").GetComponent<SpriteRenderer>());
        renderers.Add(GameObject.Find("I").GetComponent<SpriteRenderer>());
        renderers.Add(GameObject.Find("Will").GetComponent<SpriteRenderer>());
        renderers.Add(GameObject.Find("Go Out").GetComponent<SpriteRenderer>());
    }

    // Update is called once per frame
    void Update()
    {
        if (Camera.main.gameObject.GetComponent<Animator>().enabled)
            if (Camera.main.gameObject.GetComponent<Animator>().GetComponent<Animator>().GetCurrentAnimatorStateInfo(0).IsName("Idle"))
            {
                Camera.main.GetComponent<Animator>().runtimeAnimatorController = null;
                foreach (SpriteRenderer s in renderers)
                {
                    s.color = new Color(255, 255, 255);
                }
            }
    }

    private void OnMouseDown()
    {
        Camera.main.gameObject.GetComponent<Animator>().runtimeAnimatorController = controller;
        foreach(SpriteRenderer s in renderers)
        {
            s.color = new Color(255, 0, 0);
        }
    }
}

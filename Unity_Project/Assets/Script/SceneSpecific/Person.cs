using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Person : MonoBehaviour
{
    public Phase phase = Phase.WORK;
    public float speed = 1f;
    public float changePosition = 25f;
    public float walk = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        switch(phase)
        {
            case Phase.WORK:
                transform.Translate(new Vector3(walk, 0) * Time.deltaTime * speed);
                if(Input.GetAxis("Horizontal") > 0)
                {
                    transform.localScale = new Vector3(0.75f, 0.75f, 1);
                }
                else if (Input.GetAxis("Horizontal") < 0)
                {
                    transform.localScale = new Vector3(-0.75f, 0.75f, 1);
                }
                break;
            case Phase.BACK:
                transform.Translate(new Vector3(Mathf.Abs(walk) * -1, 0) * Time.deltaTime * speed);
                transform.localScale = new Vector3(-0.75f, 0.75f, 1);
                break;
        }

        if(transform.position.x <= -8)
        {
            transform.position = new Vector3(-8, transform.position.y);
        }

        if(transform.position.x >= 0)
            Camera.main.transform.position = new Vector3(transform.position.x, Camera.main.transform.position.y, Camera.main.transform.position.z);

        if(transform.position.x >= changePosition)
        {
            phase = Phase.BACK;
        }

        if(transform.position.x <= 0 && phase == Phase.BACK)
        {
            TransitionManager.instance.Go();
            Destroy(this);
        }
    }

    public enum Phase { WORK, BACK };
}

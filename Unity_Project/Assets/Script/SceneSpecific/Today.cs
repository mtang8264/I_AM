using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Today : MonoBehaviour
{
    List<SpriteRenderer> sprites = new List<SpriteRenderer>();
    public float timeTillFirstFade = 2.5f;
    public AnimationCurve curve;
    float startTime;

    bool ready = false;

    public float timeTillEnd = 2.5f;

    // Start is called before the first frame update
    void Start()
    {
        Camera.main.backgroundColor = Color.black;

        sprites.Add(GameObject.Find("But").GetComponent<SpriteRenderer>());
        sprites.Add(GameObject.Find("What").GetComponent<SpriteRenderer>());
        sprites.Add(GameObject.Find("About").GetComponent<SpriteRenderer>());

        startTime = Time.time;
    }

    // Update is called once per frame
    void Update()
    {
        if(Time.time > startTime + timeTillFirstFade && !ready)
        {
            for(int i = 0; i < sprites.Count; i ++)
            {
                sprites[i].color = new Color(255, 255, 255, curve.Evaluate(Time.time - (startTime + timeTillFirstFade)));
            }
            if (Time.time > startTime + timeTillFirstFade + 1)
            {
                ready = true;
                startTime = -1f;
            }
        }

        if(ready)
        {
            for (int i = 0; i < sprites.Count; i++)
            {
                sprites[i].color = new Color(255, 255, 255, 0);
            }

            if(Time.time > startTime + timeTillEnd && startTime != -1)
            {
                TransitionManager.instance.Go();
                GameObject.Find("Fade").GetComponent<Image>().color = new Color(1, 1, 1, 0);
                Destroy(this);
            }
        }
    }

    private void OnMouseDown()
    {
        if (!ready)
        {
            ready = true;
            startTime = -1f;
        }

        if(Camera.main.backgroundColor == Color.black)
        {
            Camera.main.backgroundColor = Color.gray;
            GetComponent<SpriteRenderer>().color = Color.gray;
        }
        else if(Camera.main.backgroundColor == Color.gray)
        {
            Camera.main.backgroundColor = Color.white;
            GetComponent<SpriteRenderer>().color = Color.black;
            startTime = Time.time;
        }
    }
}

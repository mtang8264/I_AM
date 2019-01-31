using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pointer : MonoBehaviour
{
    public Texture2D[] cursors;
    public List<Texture2D> currentCursors;
    int options;
    float minTime = 0.08f;
    float maxTime = 0.2f;
    float waitTime;
    float lastTime;

    // Start is called before the first frame update
    void Start()
    {
        DontDestroyOnLoad(gameObject);

        lastTime = Time.time;
        waitTime = Random.Range(minTime, maxTime);
        currentCursors = new List<Texture2D>(cursors);
        options = currentCursors.Count;
    }

    // Update is called once per frame
    void Update()
    {
        if (Time.time > lastTime + waitTime)
        {
            lastTime = Time.time;
            waitTime = Random.Range(minTime, maxTime);

            if (options <= 0)
            {
                currentCursors = new List<Texture2D>(cursors);
                options = currentCursors.Count;
            }

            int selection = Random.Range(0, options);
            Cursor.SetCursor(currentCursors[selection], Vector2.zero, CursorMode.Auto);

            options--;
            currentCursors.RemoveAt(selection);
        }
    }
}

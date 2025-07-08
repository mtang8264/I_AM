using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TextShake : MonoBehaviour
{
    int startCount;
    public Sprite[] sprites = new Sprite[10];
    public List<Sprite> spritesToUse = new List<Sprite>();
    public float timeToChange;
    private float lastChange;
    static readonly float minimumTime = 0.08f;
    static readonly float maximumTime = 0.22f;
    SpriteRenderer spriteRenderer;

    // Start is called before the first frame update
    void Start()
    {
        spriteRenderer = GetComponent<SpriteRenderer>();
        timeToChange = Random.Range(minimumTime, maximumTime);
        spritesToUse = new List<Sprite>(sprites);
        lastChange = Time.time;

        startCount = sprites.Length;
    }

    // Update is called once per frame
    void Update()
    {
        if (Time.time > lastChange + timeToChange)
        {
            int count = 0;
            for (int i = 0; i < spritesToUse.Count; i++)
            {
                if (spritesToUse[i] != null)
                {
                    count++;
                }
            }
            if (count == 0)
            {
                spritesToUse = new List<Sprite>(sprites);
                count = startCount;
            }

            int selection = Random.Range(0, count - 1);
            spriteRenderer.sprite = spritesToUse[selection];
            spritesToUse.RemoveAt(selection);

            lastChange = Time.time;
            timeToChange = Random.Range(minimumTime, maximumTime);
        }
    }
}

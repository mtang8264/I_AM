using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour
{
    public float force = 100;
    public GameObject orb;
    private Vector2 startPos;
    public Vector2 offset;
    bool drag = false;

    // Start is called before the first frame update
    void Start()
    {
        startPos = transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        if(drag)
        {
            transform.position = Camera.main.ScreenToWorldPoint(Input.mousePosition) - new Vector3(offset.x, offset.y);
            transform.position = new Vector3(transform.position.x, transform.position.y, 0);
        }
        else
        {
            transform.position = Vector3.Lerp(transform.position, startPos, 0.1f);
        }

        if(drag)
        {
            GetComponent<Rigidbody2D>().bodyType = RigidbodyType2D.Dynamic;
        }
        else
        {
            GetComponent<Rigidbody2D>().bodyType = RigidbodyType2D.Static;
        }
    }

    private void OnMouseDown()
    {
        offset = Camera.main.ScreenToWorldPoint(Input.mousePosition) - transform.position;
        drag = true;
    }

    private void OnMouseUp()
    {
        drag = false;
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        for(int i = 0; i < 16; i ++)
        {
            float angle = i * (360f / 16f);
            Vector3 direction = new Vector3(Mathf.Sin(Mathf.Deg2Rad * angle), Mathf.Cos(Mathf.Deg2Rad * angle));
            GameObject temp = Instantiate(orb);
            temp.transform.position = transform.position;
            temp.GetComponent<Rigidbody2D>().AddForce(direction * force, ForceMode2D.Impulse);
        }

        //Debug.Log(collision.collider.gameObject.layer);
        

        if(collision.collider.gameObject.layer != 11)
        {
            drag = false;
        }
    }
}
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class TransitionManager : MonoBehaviour
{
    [Header("The current state of the scene")]
    public State state;
    [Header("Details on entrance")]
    [Tooltip("Horizontal means a pan from either right or left. Vertical means a pan from either top or bottom.")]
    public Transition transitionIn;
    [Tooltip("For Horizontal and Vertical represents the duration and speed of the motion. For fade, it is the duration and opacity of the object.")]
    public AnimationCurve curveIn;
    [Header("Details on exit")]
    [Tooltip("Horizontal means a pan to either right or left. Vertical means a pan to either top or bottom.")]
    public Transition transitionOut;
    [Tooltip("For Horizontal and Vertical represents the duration and speed of the motion. For fade, it is the duration and opacity of the object.")]
    public AnimationCurve curveOut;

    public string targetScene;

    private bool begun = false;
    private float startTime;
    private Image fade;

    public static TransitionManager instance;

    // Start is called before the first frame update
    void Start()
    {
        if(instance != null)
        {
            Destroy(instance.gameObject);
        }
        instance = this;

        if (transitionIn == Transition.FADE || transitionOut == Transition.FADE)
            fade = GameObject.Find("Fade").GetComponent<Image>();
    }

    // Update is called once per frame
    void Update()
    {
        switch(state)
        {
            case State.IN:
                if(!begun)
                {
                    begun = true;
                    startTime = Time.time;
                }

                switch(transitionIn)
                {
                    case Transition.FADE:
                        fade.color = new Color(0, 0, 0, curveIn.Evaluate(Time.time - startTime));
                        break;
                    case Transition.HORIZONTAL:
                        Camera.main.transform.position = new Vector3(curveIn.Evaluate(Time.time - startTime), 0, -10);
                        break;
                    case Transition.VERTICAL:
                        Camera.main.transform.position = new Vector3( 0, curveIn.Evaluate(Time.time - startTime), -10);
                        break;
                }

                if(Time.time - startTime >= 1f)
                {
                    begun = false;
                    state = State.OFF;
                }

                break;
            case State.OUT:
                if (!begun)
                {
                    begun = true;
                    startTime = Time.time;
                }

                switch(transitionOut)
                {
                    case Transition.FADE:
                        fade.color = new Color(0, 0, 0, curveOut.Evaluate(Time.time - startTime));
                        break;
                    case Transition.HORIZONTAL:
                        Camera.main.transform.position = new Vector3(curveOut.Evaluate(Time.time - startTime), 0, -10);
                        break;
                    case Transition.VERTICAL:
                        Camera.main.transform.position = new Vector3(0, curveOut.Evaluate(Time.time - startTime), -10);
                        break;
                }

                if(Time.time - startTime >= 1f)
                {
                    SceneManager.LoadScene(targetScene);
                }
                break;
            case State.OFF:
                break;
        }
    }

    public void Go()
    {
        state = State.OUT;
    }

    public enum State { IN, OUT, OFF };
    public enum Transition { HORIZONTAL, VERTICAL, FADE };
}

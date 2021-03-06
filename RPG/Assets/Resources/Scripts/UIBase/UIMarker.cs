﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class UIMarker : UIBase
{

    public void AddListener(UnityAction call) {
        if(transform.GetComponent<Button>() != null)
        {
            var button = transform.GetComponent<Button>();
            button.onClick.AddListener(call);
        }
    }

    public void SetText(string txt)
    {
        if (transform.GetComponent<Text>() != null)
        {
            var text = transform.GetComponent<Text>();
            text.text = txt;
        }
    }

    public void SetSprite(string sprite)
    {
        if (transform.GetComponent<Image>() != null)
        {
            var image = transform.GetComponent<Image>();
            image.sprite = UIResourceLoader.m_instance.Load<Sprite>("Textures/" + sprite + ".png");
        }
    }

    public void SetFilledValue(float val)
    {
        if (transform.GetComponent<Slider>() != null)
        {
            var slider = transform.GetComponent<Slider>();
            slider.value = val;
        }
    }

    public void SetActive(bool v)
    {
        gameObject.SetActive(v);
    }

    public void ClearChild()
    {
        int childCount = transform.childCount;
        for (int i = 0; i < childCount; i++)
        {
            Destroy(transform.GetChild(i).gameObject);
        }

    }

    public Transform GetTransfrom()
    {
        return transform;
    }
}

import 'package:flutter/material.dart';

class ViewController extends ChangeNotifier
{
    int myIndex=0;
    bool favourite=false;

    getIdx(int idx)
    {
        myIndex=idx;
        notifyListeners();
    }

    getFavourite()
    {
        favourite=!favourite;
        notifyListeners();
    }

}


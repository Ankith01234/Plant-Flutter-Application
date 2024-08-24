import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:plant/home_page/home_page_model/home_page_model.dart';

class HomePageController extends ChangeNotifier
{
    bool isLoading=false;
    List<Datum> myData=[];
    int index=0;
    int count=0;
    int sizeLength=0;

    HomePageController()
    {
        getPlants();
    }

    getIndex(int idx)
    {
        index=idx;
        notifyListeners();
    }

    getPlants()async
    {
        isLoading = true;
        notifyListeners();

        await Future.delayed(const Duration(seconds: 5));

        final url=Uri.parse("https://www.jsonkeeper.com/b/6Z9C");
        final api=await http.get(
            url,
            headers: {
                "Content-Type":"application/json"
            }
        );

        final decodeData=jsonDecode(api.body);
        final plantData=PlantDataModel.fromJson(decodeData);

        if(api.statusCode==200)
        {
            myData=plantData.data;
            count=myData.length;
            sizeLength=plantData.data[0].availableSize.length;
            isLoading=false;
            notifyListeners();
        }
        else
        {
            if (kDebugMode)
            {
              print("Error ${api.statusCode}");
            }
        }

    }

}

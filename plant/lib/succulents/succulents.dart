import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant/riverpod/riverpod.dart';
import 'package:plant/resources/resources.dart';
import 'package:plant/view/view_page/view_page.dart';
import 'package:shimmer/shimmer.dart';

class Succulents extends StatelessWidget {
  Succulents({super.key});

  final List<MaterialColor> myColors = [
    Color.blueGreyColor,
    Color.brownColor,
    Color.brownColor
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.whiteColor,
      body: Consumer(builder: (context, watch, child) {
        final plantListener = watch.watch(plantProvider);
        return plantListener.isLoading
            ? shimmerEffect()
            : Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: plantListener.count,
                      itemBuilder: (BuildContext context, index) {
                        final rec = plantListener.myData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewPage(idx: index)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Color.whiteColor,
                              child: Row(
                                children: [
                                  Container(
                                      height: 120,
                                      width: 120,
                                      color: myColors[index],
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Image.network(
                                              rec.imageUrl,
                                            ),
                                            Container(
                                                color: Color.whiteColor,
                                                child: const Icon(
                                                  Icons.favorite_border,
                                                  color: Color.greyColor,
                                                ))
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            rec.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 26),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${rec.availableSize[0].toString()} ${rec.unit}",
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        "${rec.price} ${rec.priceUnit}",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  //Text("${rec.rating.toString()} ",style:const  TextStyle(fontSize: 26)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  Container(
                    height: 150,
                    width: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlueAccent.withOpacity(0.3),
                          Colors.orange.withOpacity(0.25)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20, right: 40),
                              child: Text(
                                "Free Shipping",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: "on orders ",
                                    style: TextStyle(
                                        color: Color.greyColor, fontSize: 30)),
                                WidgetSpan(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color.deepOrangeAccentColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: Text("over \$ 100",
                                              style: TextStyle(
                                                  color: Color.whiteColor,
                                                  fontSize: 20)),
                                        ))),
                              ])),
                            )
                          ],
                        ),
                        // Image.asset("Images/Ship_order_Image.png"),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }

  shimmerEffect() {
    return Shimmer.fromColors(
        baseColor: Color.greyColor,
        highlightColor: Color.whiteColor,
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration:
                                    const BoxDecoration(color: Color.greyColor),
                              )),
                          Column(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder: (BuildContext context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 20,
                                          width: 200,
                                          decoration: const BoxDecoration(
                                              color: Color.greyColor),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            Container(
              height: 150,
              width: 380,
              decoration: const BoxDecoration(color: Color.greyColor),
            ),
          ],
        ));
  }
}

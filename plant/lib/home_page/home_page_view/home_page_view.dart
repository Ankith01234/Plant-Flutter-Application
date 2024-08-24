import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant/resources/resources.dart';
import 'package:plant/riverpod/riverpod.dart';
import 'package:plant/succulents/succulents.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<String> myList = ["All", "Succulents", "In pots", "Dried flowers"];

  PageController pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final plantListener = watch.watch(plantProvider);
        return SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Color.whiteColor,
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "AllPlants",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Houseplants",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: myList.length,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () {
                              plantListener.getIndex(index);
                              selectedIndex = plantListener.index;
                              pageController.jumpToPage(plantListener.index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? Color.brownColor
                                      : Color.greyColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    myList[index],
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: //selectedIndex == index
                                            // ? Color.greyColor
                                            Color.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 600,
                    child: PageView(
                      controller: pageController,
                      children: [
                        const Center(child: Text("All")),
                        Succulents(),
                        const Center(child: Text("In Pots"),),
                        const Center(child: Text("Dried Flowers"),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant/riverpod/riverpod.dart';
import 'package:plant/resources/resources.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key, required this.idx});

  final int idx;

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final plantListener = watch.watch(plantProvider);
        final viewListener = watch.watch(viewProvider);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
          ),
          body: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, index) {
                    final rec = plantListener.myData[index];
                    return widget.idx == index
                        ? Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: 400,
                                child: Image.network(rec.imageUrl),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      rec.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${rec.price} ${rec.priceUnit}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Color.yellowColor,
                                      size: 18,
                                    ),
                                    Text(
                                      rec.rating.toString(),
                                      style: const TextStyle(
                                          color: Color.yellowColor,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      "Choose size",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width -
                                          10,
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: plantListener.myData[index]
                                              .availableSize.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            final rec = plantListener
                                                .myData[widget.idx];
                                            return GestureDetector(
                                              onTap: () {
                                                viewListener.getIdx(index);
                                                selectedIndex =
                                                    viewListener.myIndex;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: selectedIndex ==
                                                              index
                                                          ? Color.brownColor
                                                          : Color
                                                              .blueGreyColorShade100),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "${rec.availableSize[index].toString()} ${rec.unit}",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: selectedIndex ==
                                                                  index
                                                              ? Color.whiteColor
                                                              : Color
                                                                  .brownColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
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
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 10),
                                child: Text(
                                  rec.description,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                        color: Color.greyColor.shade300,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              viewListener.getFavourite();
                                            },
                                            child: viewListener.favourite
                                                ? const Icon(
                                                    Icons.favorite,
                                                    size: 30,
                                                  )
                                                : const Icon(
                                                    Icons.favorite_border,
                                                    size: 30,
                                                  ),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      width: 250,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.brownColor,
                                          ),
                                          child: const Text(
                                            "Add to cart",
                                            style: TextStyle(
                                                color: Color.whiteColor,
                                                fontSize: 15),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox();
                  }),
            ],
          ),
        );
      },
    );
  }
}

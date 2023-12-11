import 'package:covid_tracker/View/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.totalRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableRow(
                          Title: "Cases", value: widget.totalCases.toString()),
                      SizedBox(
                        height: 8,
                      ),
                      ReusableRow(
                          Title: "Recovered",
                          value: widget.totalRecovered.toString()),
                      SizedBox(
                        height: 8,
                      ),
                      ReusableRow(
                          Title: "Death", value: widget.totalDeaths.toString()),
                      SizedBox(
                        height: 8,
                      ),
                      ReusableRow(
                          Title: "Critical", value: widget.critical.toString()),
                      SizedBox(
                        height: 8,
                      ),
                      ReusableRow(
                          Title: "Today Recovery",
                          value: widget.totalRecovered.toString()),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

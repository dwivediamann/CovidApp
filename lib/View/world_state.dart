import 'package:covid_tracker/Model/world_state_model.dart';
import 'package:covid_tracker/Service/states_services.dart';
import 'package:covid_tracker/View/country_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      // give the duration of animation

      duration: Duration(seconds: 3),
      vsync: this)
    ..repeat();
// it is used to dispose the data
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  // all the color used are in the pie chart

  final piecolorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

// loading the future data from api from stateservices
// calling a class with the help of constructure
  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            FutureBuilder(
              future: statesServices.fetechapi(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          // since the data of the map is of double type
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Death":
                              double.parse(snapshot.data!.deaths.toString())
                        },
                        colorList: piecolorList,
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        legendOptions:
                            LegendOptions(legendPosition: LegendPosition.left),
                        chartRadius: 180,
                        chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                Title: "Total Cases",
                                value: snapshot.data!.cases.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ReusableRow(
                                Title: "Total Recovery",
                                value: snapshot.data!.recovered.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ReusableRow(
                                Title: "Total Death ",
                                value: snapshot.data!.deaths.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ReusableRow(
                                Title: "Active",
                                value: snapshot.data!.active.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ReusableRow(
                                Title: "Critical",
                                value: snapshot.data!.critical.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ReusableRow(
                                Title: "Today Death ",
                                value: snapshot.data!.todayDeaths.toString(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ReusableRow(
                                Title: "Today Cases",
                                value: snapshot.data!.todayCases.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryListScreen(),
                                  ));
                            },
                            child: Text(
                              "Track Countries",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green),
                              minimumSize: MaterialStateProperty.all(
                                Size(150.0,
                                    50.0), // Adjust the button size as needed
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String Title, value;
  ReusableRow({super.key, required this.Title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(Title), Text(value)],
    );
  }
}

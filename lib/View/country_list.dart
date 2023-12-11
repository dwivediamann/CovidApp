import 'package:covid_tracker/Service/states_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController contrycontroller = TextEditingController();
  // calling the class with its constructor
  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: contrycontroller,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search With The CountryName",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue[300],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
              keyboardType: TextInputType.text,
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.countrylistapi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        baseColor: Colors.grey.shade600,
                        highlightColor: Colors.grey.shade600);
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]["country"];
                    // checking is user doesnot search anything
                    if (contrycontroller.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]
                                          ['cases'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                    ),
                                  ));
                            },
                            child: ListTile(
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"])),
                              title: Text(snapshot.data![index]["country"]),
                              subtitle: Text(
                                  snapshot.data![index]["cases"].toString()),
                            ),
                          ),
                        ],
                      );
                    } else if (name
                        .toUpperCase()
                        .contains(contrycontroller.text.toUpperCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]
                                          ['cases'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                    ),
                                  ));
                            },
                            child: ListTile(
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"])),
                              title: Text(snapshot.data![index]["country"]),
                              subtitle: Text(
                                  snapshot.data![index]["cases"].toString()),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}

import 'package:covid_19_tracker/Services/StatesServices.dart';
import 'package:covid_19_tracker/view/SingleCountryDetails.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountrieslistScreen extends StatefulWidget {
  const CountrieslistScreen({super.key});

  @override
  State<CountrieslistScreen> createState() => _CountrieslistScreenState();
}

class _CountrieslistScreenState extends State<CountrieslistScreen> {
  late Statesservices statesservices;
  late TextEditingController searchcontroller;
  late String searchText;

  @override
  void initState() {
    super.initState();
    statesservices = Statesservices();
    searchcontroller = TextEditingController();
    searchText = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
           backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
        
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back
            },
          ),
             backgroundColor: Colors.grey.shade300,
          title: const Text('Select Country'),
          centerTitle: true,
          elevation: 2,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Search with country name',
                  suffixIcon: searchcontroller.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            searchcontroller.text = "";
                            setState(() {
                              searchText = '';
                            });
                          },
                          child: const Icon(Icons.clear),
                        ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: statesservices.CountriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 100,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchText.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Singlecountrydetails (
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,
                                  )));
                                },
                                child: ListTile(
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']['flag'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      "Affected: ${snapshot.data![index]['cases']}"),
                                ),
                              ),
                            ],
                          );
                        } else if (name.toLowerCase().contains(searchText)) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Singlecountrydetails(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,
                                  )));
                                },
                                child: ListTile(
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']['flag'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      "Affected: ${snapshot.data![index]['cases']}"),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
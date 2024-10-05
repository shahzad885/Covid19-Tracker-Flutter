import 'package:covid_19_tracker/Models/WorldStatesModel.dart';
import 'package:covid_19_tracker/Services/StatesServices.dart';
import 'package:covid_19_tracker/view/CountriesList.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => __WorldStatesScreenState();
}

class __WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  final colorList = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Statesservices statesservices = Statesservices();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),

          FutureBuilder(
            future: statesservices.FechWorldStatesRecord(),
            builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(color: Colors.white,controller:_controller , size: 50,),
                );
              }

              else{
               return Column(children: [
       PieChart(
            dataMap:  {"Total": double.parse(snapshot.data!.cases!.toString()),
             "Recovered": double.parse(snapshot.data!.recovered!.toString()),
              "Deaths": double.parse(snapshot.data!.deaths!.toString())
              },
              chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true ),
            chartRadius: screenWidth / 3.2,
            animationDuration: const Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList: colorList,
            legendOptions:
                const LegendOptions(legendPosition: LegendPosition.left),
          ),
          //  SizedBox(height: screenHeight*0.05,),
         
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * .03),
            child: Card(
                   color: Colors.grey[300],
                   elevation: 2,
                child: Column(
              children: [
                 ResusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                ResusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                ResusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ResusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                ResusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                ResusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                ResusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
               
              ],
            )),
          ),
           GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const CountrieslistScreen();
                    },));
                  },
                  child: Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              border:    Border.all(color: Colors.grey.shade400, width: 1),

                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 208, 207, 207),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(1, 2),
                  )
                ],
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: const Center(child: Text('Track Countries',style: TextStyle(fontWeight: FontWeight.bold),)),
          ),
                )
                ],);

              }
            },
          ),

   
        ],
      ),
    )));
  }
}

class ResusableRow extends StatelessWidget {
  String title, value;
  ResusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(left: 20 , right: 20 , top: 10 , bottom: 5),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title),
            Text(value),
          ]),
          const SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }
}

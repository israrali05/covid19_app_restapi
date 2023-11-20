import 'package:covid19_app_restapi/models/covid_19_model.dart';
import 'package:covid19_app_restapi/provider/world_state_controller.dart';
import 'package:covid19_app_restapi/utils/app_colors.dart';
import 'package:covid19_app_restapi/view/country_list/country_list.dart';
import 'package:covid19_app_restapi/view/home_screen/components/row_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
      @override
  void initState() {
    super.initState();
    // Fetch country data when the widget is first created
    Provider.of<CovidDataProvider>(context, listen: false).fetchCovidData();
  }
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<CovidDataProvider>(context);
    // provider.fetchCovidData();
    // Map<String, double> dataMap = {
    //   "Total": 40,
    //   "Recovered": 10,
    //   "Death": 20,
    // };
    final colorList = <Color>[
      AppColors.greenColor,
      AppColors.redColor,
      AppColors.blueColor
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: const PageScrollPhysics(),
          child:
              Consumer<CovidDataProvider>(builder: (context, provider, child) {
            WorldStatesModel? covidData = provider.covidData;
            // If fetchPosts is asynchronous, you can use a FutureBuilder
            if (covidData == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              // Assuming your WorldStateController holds a list of WorldStatesModel
              // List<WorldStatesModel> worldStatesModel =
              //     provider.worldStatesModel;

              return Column(children: [
                SizedBox(
                  height: 0.07.sh,
                ),
                PieChart(
                    dataMap: {
                      "Total": double.parse(covidData.cases.toString()),
                      "Recovered": double.parse(covidData.recovered.toString()),
                      "Death": double.parse(covidData.deaths.toString()),
                    },
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 40,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    colorList: colorList,
                    initialAngleInDegree: 70,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 15,
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.left,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appWhiteColor),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    )),
                Container(
                  // height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: Card(
                    color: AppColors.appWhiteColor.withOpacity(0.9),
                    child: Column(
                      children: [
                        ReusableRow(
                          title: "Total",
                          value: covidData.cases.toString(),
                        ),
                        ReusableRow(
                          title: "Recovered",
                          value: covidData.recovered.toString(),
                        ),
                        ReusableRow(
                          title: "Deaths",
                          value: covidData.deaths.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.34.sh,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => CountryListScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Center(
                        child: Text(
                      "Track Countries",
                      style: TextStyle(
                          color: AppColors.appWhiteColor, fontSize: 18),
                    )),
                  ),
                )
              ]);
            }
          }),
        ),
      ),
    );
  }
}

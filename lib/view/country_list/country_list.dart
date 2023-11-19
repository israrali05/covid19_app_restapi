import 'package:covid19_app_restapi/provider/world_state_controller.dart';
import 'package:covid19_app_restapi/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
    @override
  void initState() {
    super.initState();
    // Fetch country data when the widget is first created
    Provider.of<CovidDataProvider>(context, listen: false).fetchAllCountriesData();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CovidDataProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text("Country List"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(children: [
          TextField(
            onChanged: (value) {
              provider.filterCountries(value);
            },
            // controller: searchController,
            cursorColor: AppColors.appblackColor,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.w),
              hintText: 'Enter Country Name',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: AppColors.appblackColor,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0.w),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Consumer<CovidDataProvider>(builder: (context, provider, child) {
            if (provider.filteredCountries.isEmpty) {
              return Expanded(
                child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade100,
                        child: ListTile(
                          leading: Container(
                            color: AppColors.appWhiteColor,
                            height: 50,
                            width: 50,
                          ),
                          title: Container(
                              color: AppColors.appWhiteColor,
                              height: 10,
                              width: double.infinity),
                          subtitle: Container(
                              color: AppColors.appWhiteColor,
                              height: 10,
                              width: double.infinity),
                        ),
                      );
                    }),
              );
            }
            return Expanded(
                child: ListView.builder(
                    itemCount: provider.filteredCountries.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          provider.filteredCountries[index].countryInfo!.flag
                              .toString(),
                          height: 50,
                          width: 50,
                        ),
                        title: Text(
                          provider.filteredCountries[index].country.toString(),
                          style: TextStyle(color: AppColors.appWhiteColor),
                        ),
                        subtitle: Text(
                            provider.filteredCountries[index].cases.toString(),
                            style: TextStyle(color: AppColors.appWhiteColor)),
                      );
                    }));
          })
        ]),
      ),
    );
  }
}

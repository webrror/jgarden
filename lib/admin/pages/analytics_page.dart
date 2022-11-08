import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:jgarden/admin/services/admin_services.dart';
import 'package:jgarden/admin/widgets/chart_category_products.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/big_text.dart';
import 'package:jgarden/widgets/loader.dart';

import '../models/sales.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null 
    ? const Loader()
    : Column(
      children: [
        BigText(text: '\₹$totalSales'),
        SizedBox(
          height: Dimensions.height250,
          child: CategoryProductsChart(seriesList: [
            charts.Series(
              id: 'Sales', data: earnings!, 
              domainFn: (Sales sales,_) => sales.label, 
              measureFn: (Sales sales,_) => sales.earning,
              colorFn: (_,__)=>charts.ColorUtil.fromDartColor(AppColors.mainColor)
            )
          ]),
        )
      ],
    );
  }
}

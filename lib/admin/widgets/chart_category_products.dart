import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import '../models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  const CategoryProductsChart({super.key, required this.seriesList});
  final List<charts.Series<Sales, String>> seriesList;

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}

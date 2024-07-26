import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';

class BorrowerDashboardPage extends StatelessWidget {
  const BorrowerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Borrower Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle('Loan Progress'),
            const SizedBox(height: 10),
            _buildLoanProgress(),
            const SizedBox(height: 20),
            _buildTitle('Loans Overview'),
            const SizedBox(height: 10),
            _buildPieChart(),
            const SizedBox(height: 20),
            _buildTitle('Repayment Schedule'),
            const SizedBox(height: 10),
            _buildLineChart(),
            const SizedBox(height: 20),
            _buildTitle('Total Borrowed vs Repaid'),
            const SizedBox(height: 10),
            _buildBarChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildLoanProgress() {
    double progress = 0.65; // Example progress (65%)
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
              strokeWidth: 8,
            ),
            const SizedBox(height: 10),
            const Text(
              '65% of Loan Repaid',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              '4 months remaining',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: 40,
              title: 'Personal',
              radius: 50,
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 3, 29, 77)),
            ),
            PieChartSectionData(
              color: Colors.orange,
              value: 30,
              title: 'Buss..',
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 77, 69, 3)),
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 20,
              title: 'Education',
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 20, 88, 3)),
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 10,
              title: 'Med',
              radius: 50,
              titleStyle:
                  const TextStyle(color: Color.fromARGB(230, 77, 36, 3)),
            ),
          ],
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        title: const ChartTitle(text: 'Repayment Schedule'),
        series: <CartesianSeries>[
          LineSeries<ChartData, String>(
            dataSource: [
              ChartData('Jan', 500),
              ChartData('Feb', 700),
              ChartData('Mar', 300),
              ChartData('Apr', 800),
              ChartData('May', 600),
              ChartData('Jun', 400),
            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        title: const ChartTitle(text: 'Total Borrowed vs Repaid'),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: [
              ChartData('Borrowed', 50000),
              ChartData('Repaid', 30000),
            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Colors.teal,
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

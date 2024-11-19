import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final random = Random();
  List<Map<String, dynamic>> companiesData = [];
  String? selectedYear = '2023';
  String? selectedMonth = 'January';

  // Generates random monthly data for companies
  void generateRandomCompaniesData() {
    companiesData = List.generate(10, (index) {
      double salesAmount =
          random.nextDouble() * 5000; // Random sales amount for the month
      double salesProgress = random.nextDouble(); // Random progress (0 to 1)

      return {
        'companyName': 'Company ${index + 1}',
        'salesAmount': salesAmount,
        'salesProgress': salesProgress,
      };
    });
  }

  // Calculate the overall income for the selected month
  double getOverallIncome() {
    return companiesData.fold(
        0, (sum, company) => sum + company['salesAmount']);
  }

  // Generate Pie Chart sections based on sales amounts
  List<PieChartSectionData> showingSections() {
    double totalSales = getOverallIncome();
    return companiesData.map((company) {
      double companySales = company['salesAmount'];
      double percentage = totalSales > 0 ? companySales / totalSales : 0;
      return PieChartSectionData(
        color: Colors.primaries[
            companiesData.indexOf(company) % Colors.primaries.length],
        radius: 110,
        value: percentage * 100,
        title: '${(percentage * 100).toStringAsFixed(1)}%',
        titleStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    generateRandomCompaniesData(); // Initialize data when the page is first loaded
  }

  @override
  Widget build(BuildContext context) {
    double overallIncome = getOverallIncome();

    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Column(
        children: [
          // Filter section with year and month dropdowns
          Container(
            color: const Color.fromRGBO(106, 14, 3, 1.000),
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Year Dropdown
                DropdownButton<String>(
                  dropdownColor: const Color.fromRGBO(255, 164, 153, 1.000),
                  value: selectedYear,
                  hint:
                      const Text("Year", style: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                    generateRandomCompaniesData(); // Regenerate data when the year changes
                  },
                  items: ['2022', '2023', '2024']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Color.fromRGBO(140, 29, 16, 1.000)),
                        ));
                  }).toList(),
                ),
                // Month Dropdown
                DropdownButton<String>(
                  dropdownColor: const Color.fromRGBO(255, 164, 153, 1.000),
                  value: selectedMonth,
                  hint: const Text("Month",
                      style: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                    generateRandomCompaniesData(); // Regenerate data when the month changes
                  },
                  items: [
                    'January',
                    'February',
                    'March',
                    'April',
                    'May',
                    'June',
                    'July',
                    'August',
                    'September',
                    'October',
                    'November',
                    'December'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Color.fromRGBO(140, 29, 16, 1.000)),
                        ));
                  }).toList(),
                ),
              ],
            ),
          ),
          // Top part with pie chart and indicator
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: 180,
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 25,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red.shade100,
                    child: ListView.builder(
                      itemCount: companiesData.length,
                      itemBuilder: (context, index) {
                        final color =
                            Colors.primaries[index % Colors.primaries.length];
                        return ListTile(
                          leading: Icon(
                            Icons.business,
                            color: color, // Dynamic color for the icon
                          ),
                          title: Text(companiesData[index]['companyName']),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom part with scrollable list
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                color: const Color.fromRGBO(255, 112, 95, 1.000),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Text(
                            'OVERALL INCOME',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\RM${overallIncome.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: companiesData.length,
                        itemBuilder: (context, index) {
                          final company = companiesData[index];
                          final color =
                              Colors.primaries[index % Colors.primaries.length];
                          return ListTile(
                            leading: Icon(
                              Icons.business,
                              color: color, // Dynamic color for the icon
                            ),
                            title: Text(
                                '${company['companyName']} - Sales: \RM${company['salesAmount'].toStringAsFixed(2)}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LinearProgressIndicator(
                                  value: company['salesProgress'],
                                  backgroundColor: Colors.grey.shade200,
                                  color: color, // Matching progress bar color
                                  minHeight: 8,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Sales Progress: ${(company['salesProgress'] * 100).toStringAsFixed(0)}%',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

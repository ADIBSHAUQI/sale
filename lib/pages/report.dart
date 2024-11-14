import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? selectedCompany;
  int selectedWeek = 1;
  String? selectedYear;
  String? selectedMonth;

  // Sample data for each week
  final Map<int, Map<String, String>> weeklyData = {
    1: {
      'saleValue': 'RM 500,000',
      'negotiation': 'Negotiated price: RM 480,000',
      'issues': 'Issue with paperwork',
      'suggestion': 'Consider new marketing strategies',
    },
    2: {
      'saleValue': 'RM 450,000',
      'negotiation': 'Negotiated price: RM 430,000',
      'issues': 'Delay in delivery',
      'suggestion': 'Improve supplier communication',
    },
    3: {
      'saleValue': 'RM 550,000',
      'negotiation': 'Negotiated price: RM 520,000',
      'issues': 'Stock shortages',
      'suggestion': 'Increase inventory levels',
    },
    4: {
      'saleValue': 'RM 600,000',
      'negotiation': 'Negotiated price: RM 570,000',
      'issues': 'Shipping issues',
      'suggestion': 'Switch logistics partners',
    },
    5: {
      'saleValue': 'RM 470,000',
      'negotiation': 'Negotiated price: RM 450,000',
      'issues': 'Payment delays',
      'suggestion': 'Review credit terms with clients',
    },
  };

  final List<String> years = ['2022', '2023', '2024'];
  final List<String> months = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Column(
        children: [
          Container(
            color: Colors.red.shade100,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  dropdownColor: const Color.fromRGBO(255, 164, 153, 1.000),
                  hint: const Text("Company",
                      style: TextStyle(color: Colors.black)),
                  value: selectedCompany,
                  onChanged: (value) {
                    setState(() {
                      selectedCompany = value;
                    });
                  },
                  items: ['Company A', 'Company B', 'Company C']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0))),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  dropdownColor: const Color.fromRGBO(255, 164, 153, 1.000),
                  hint:
                      const Text("Year", style: TextStyle(color: Colors.black)),
                  value: selectedYear,
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                  items: years.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0))),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  dropdownColor: const Color.fromRGBO(255, 164, 153, 1.000),
                  hint: const Text("Month",
                      style: TextStyle(color: Colors.black)),
                  value: selectedMonth,
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                  items: months.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0))),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                if (selectedCompany != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$selectedCompany income',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                if (selectedCompany != null)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'RM 10',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: 180,
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        int week = index + 1;
                        return TextButton(
                          onPressed: () {
                            setState(() {
                              selectedWeek = week;
                            });
                          },
                          child: Text(
                            'Week $week',
                            style: TextStyle(
                              color: selectedWeek == week
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.all(8.0),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        children: [
                          buildInfoCard(
                              'Sale Value',
                              weeklyData[selectedWeek]?['saleValue'] ?? 'N/A',
                              Colors.green),
                          buildInfoCard(
                              'Sale Negotiation',
                              weeklyData[selectedWeek]?['negotiation'] ?? 'N/A',
                              Colors.blue),
                          buildInfoCard(
                              'Issues',
                              weeklyData[selectedWeek]?['issues'] ?? 'N/A',
                              Colors.red),
                          buildInfoCard(
                              'Suggestions',
                              weeklyData[selectedWeek]?['suggestion'] ?? 'N/A',
                              Colors.orange),
                        ],
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

  Widget buildInfoCard(String title, String content, Color contentColor) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(color: Colors.blue, radius: 60),
      PieChartSectionData(color: Colors.green, radius: 60),
      PieChartSectionData(color: Colors.red, radius: 60),
      PieChartSectionData(color: Colors.yellow, radius: 60),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Column(
        children: [
          // Filter section with year and month dropdowns
          Container(
            color: const Color.fromARGB(
                255, 122, 23, 23), // Set background color of the filter section
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the dropdowns
              children: [
                // Year Dropdown
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0), // Add spacing between dropdowns
                  child: DropdownButton<String>(
                    dropdownColor: const Color.fromARGB(255, 219, 55, 55),
                    hint: Text("Year",
                        style: TextStyle(
                            color: Colors.white)), // Change hint color
                    onChanged: (value) {
                      // Handle year selection
                    },
                    items: ['2022', '2023', '2024']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color:
                                  Colors.white), // Change dropdown option color
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Month Dropdown
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 5.0), // Add spacing between dropdowns
                  child: DropdownButton<String>(
                    dropdownColor: const Color.fromARGB(255, 219, 55, 55),
                    hint: Text("Month",
                        style: TextStyle(
                            color: Colors.white)), // Change hint color
                    onChanged: (value) {
                      // Handle month selection
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
                          style: TextStyle(
                              color:
                                  Colors.white), // Change dropdown option color
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          // Top part with pie chart and indicator
          Expanded(
            flex: 1, // Flex adjusted to prioritize the pie chart size
            child: Row(
              children: [
                // Pie chart on the left
                Expanded(
                  flex: 2, // Adjust width for pie chart
                  child: AspectRatio(
                    aspectRatio: 1, // Aspect ratio for square pie chart
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: 180,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 2,
                        centerSpaceRadius: 15,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                // Indicator list on the right
                Expanded(
                  flex: 1, // Adjust the width for indicator list
                  child: Container(
                    color: Colors.red.shade100,
                    child: ListView.builder(
                      itemCount: showingSections()
                          .length, // Dynamic number of sections
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.bubble_chart,
                            color: sectionColors()[index],
                          ),
                          title: Text('Section ${index + 1}'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom part with scrollable list (optional section)
          Expanded(
            flex: 2, // Adjust height for the bottom list
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), // Rounded top-left corner
                topRight: Radius.circular(20), // Rounded top-right corner
              ),
              child: Container(
                color: const Color.fromARGB(255, 255, 117, 90),
                child: Column(
                  children: [
                    // Center the title and the total income amount
                    const Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            // Title: OVERALL INCOME
                            Text(
                              'OVERALL INCOME',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            // Total Income amount
                            SizedBox(
                                height: 8), // Space between title and amount
                            Text(
                              '\RM123,456.78', // Replace with your dynamic total income calculation
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // Customize the color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Spacer between title/amount and the list of data points
                    SizedBox(height: 16),
                    // The actual list of data points
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            100, // Example list items, adjust to reflect actual data
                        itemBuilder: (context, index) {
                          // Example sales data - Replace with actual sales data logic
                          double salesProgress = (index + 1) /
                              100; // Example: sales progress as percentage
                          double salesAmount =
                              (salesProgress * 1000); // Example: sales amount

                          return ListTile(
                            leading: Icon(
                              Icons.bubble_chart,
                              color: const Color.fromARGB(255, 243, 198, 33),
                            ),
                            title: Text('Data point #$index'),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Show the sales amount at the top of each item
                                  Text(
                                    'Sales Amount: \$${salesAmount.toStringAsFixed(2)}', // Display sales amount
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      height:
                                          4), // Space between amount and progress bar
                                  // Progress bar for sales indicator
                                  LinearProgressIndicator(
                                    value: salesProgress,
                                    backgroundColor: Colors.grey.shade200,
                                    color: Colors.blue,
                                    minHeight: 8,
                                  ),
                                  SizedBox(
                                      height:
                                          8), // Space after the progress bar
                                  // Show the sales percentage at the bottom
                                  Text(
                                    'Sales Progress: ${(salesProgress * 100).toStringAsFixed(0)}%', // Display sales as percentage
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
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

  // Function to return the pie chart sections data
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        radius: 60,
      ),
      PieChartSectionData(
        color: Colors.green,
        radius: 60,
      ),
      PieChartSectionData(
        color: Colors.red,
        radius: 60,
      ),
      PieChartSectionData(
        color: Colors.yellow,
        radius: 60,
      ),
    ];
  }

  // Colors for each section, used in the ListView indicator
  List<Color> sectionColors() {
    return [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow,
    ];
  }
}

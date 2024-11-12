import 'package:flutter/material.dart';

class SalesEntryPage extends StatefulWidget {
  const SalesEntryPage({super.key});

  @override
  State<SalesEntryPage> createState() => _SalesEntryPageState();
}

class _SalesEntryPageState extends State<SalesEntryPage> {
  // Sample company names
  final List<String> companies = ['Company A', 'Company B', 'Company C'];

  // Controller and variables for handling form data
  String selectedCompany = 'Company A';
  DateTime selectedDate = DateTime.now();
  final TextEditingController salesValueController = TextEditingController();
  final TextEditingController salesNegotiationController =
      TextEditingController();
  final TextEditingController issuesController = TextEditingController();
  final TextEditingController suggestionsController = TextEditingController();

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Centered Title
                const Center(
                  child: const Text(
                    'SALE ENTRY',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 122, 23, 23),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Company Dropdown
                const Text(
                  'Select Company',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedCompany,
                  items: companies.map((String company) {
                    return DropdownMenuItem<String>(
                      value: company,
                      child: Text(company),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCompany = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Date Picker
                const Text(
                  'Select Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Sales Value Field
                const Text(
                  'Sales Value',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: salesValueController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter sales value',
                  ),
                ),
                const SizedBox(height: 16),

                // Sales in Negotiation Field
                const Text(
                  'Sales in Negotiation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: salesNegotiationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter sales in negotiation',
                  ),
                ),
                const SizedBox(height: 16),

                // Issues Field
                const Text(
                  'Issues',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: issuesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Describe any issues',
                  ),
                ),
                const SizedBox(height: 16),

                // Suggestions Field
                const Text(
                  'Suggestions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: suggestionsController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter any suggestions',
                  ),
                ),
                const SizedBox(height: 16),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle saving the sales entry
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 122, 23, 23),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

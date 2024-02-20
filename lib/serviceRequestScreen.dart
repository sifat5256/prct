import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ServiceRequestScreen extends StatelessWidget {
  final List<int> selectedHolidays = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Request Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(label: 'Name'),
            const SizedBox(height: 16.0),
            _buildTextField(label: 'Phone Number', keyboardType: TextInputType.phone),
            const SizedBox(height: 16.0),
            _buildTextField(label: 'Available Time', suffixIcon: Icons.access_time, onTap: () {
              // Implement time picker functionality
            }),
            const SizedBox(height: 16.0),
            _buildFrequencyDropdown(),
            const SizedBox(height: 16.0),
            _buildServiceDropdown(),
            const SizedBox(height: 16.0),
            _buildChildrenOrEldersInfo(),
            const SizedBox(height: 16.0),
            _buildGenderPreferenceDropdown(), // Changed to dropdown
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(label: 'Work Start Date', suffixIcon: Icons.calendar_today, onTap: () {
                    // Implement calendar picker functionality
                  }),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTextField(label: 'Work Start Time', suffixIcon: Icons.access_time, onTap: () {
                    // Implement time picker functionality
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildHolidaySelection(),
            const SizedBox(height: 16.0),
            _buildBudgetSelection(),
            const SizedBox(height: 16.0),
            _buildDropdown(label: 'Select City', items: ['City A', 'City B', 'City C', 'City D']),
            const SizedBox(height: 16.0),
            _buildTextField(label: 'Select Location'),
            const SizedBox(height: 16.0),
            _buildTextField(label: 'Full Address'),
            const SizedBox(height: 16.0),
            _buildHowHeardAboutUs(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Submit form logic
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType keyboardType = TextInputType.text, IconData? suffixIcon, Function? onTap}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon != null ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: onTap != null ? () => onTap() : null,
        ) : null,
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildFrequencyDropdown() {
    return DropdownButtonFormField<String>(
      items: ['Hourly', 'Daily', 'Weekly', 'Monthly']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {},
      decoration: const InputDecoration(labelText: 'How frequently do you need the service?'),
    );
  }

  Widget _buildServiceDropdown() {
    return DropdownButtonFormField<String>(
      items: ['Nanny', 'Caregiver', 'Nursing', 'Hospital Assistant']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {},
      decoration: const InputDecoration(labelText: 'Select the service you require'),
    );
  }

  Widget _buildChildrenOrEldersInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Children/Elders Information'),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: _buildTextField(label: 'Number of Children/Elders'),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: _buildAddButton(label: 'Add Child/Elder'),
            ),
          ],
        ),
        // Dynamic fields for child/elder info can be added here based on user interaction
      ],
    );
  }

  Widget _buildAddButton({required String label}) {
    return ElevatedButton(
      onPressed: () {
        // Add logic to handle adding more children/elders
      },
      child: Text(label),
    );
  }

  Widget _buildGenderPreferenceDropdown() { // Updated method name
    return DropdownButtonFormField<String>(
      items: ['Male', 'Female', 'Other'] // Options for gender
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {},
      decoration: const InputDecoration(labelText: 'Caregiver Gender Preference'), // Label
    );
  }

  Widget _buildHolidaySelection() {
    return Wrap(
      children: List<Widget>.generate(7, (index) {
        final day = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1 - index));
        return Row(
          children: [
            Checkbox(
              value: selectedHolidays.contains(day.weekday),
              onChanged: (value) {
                if (value != null && value) {
                  selectedHolidays.add(day.weekday);
                } else {
                  selectedHolidays.remove(day.weekday);
                }
              },
            ),
            Text(DateFormat.E().format(day)),
          ],
        );
      }),
    );
  }

  Widget _buildBudgetSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Budget'),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(child: _buildDropdown(label: 'Per', items: ['Hour', 'Day', 'Week', 'Month'])),
            const SizedBox(width: 16.0),
            Expanded(child: _buildTextField(label: 'Amount')),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({required String label, required List<String> items}) {
    return DropdownButtonFormField<String>(
      items: items
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {},
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildHowHeardAboutUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('How did you hear about us?'),
        Column(
          children: [
            Radio(value: 'Friends', groupValue: null, onChanged: (value) {}),
            const Text('Friends'),
            Radio(value: 'Family', groupValue: null, onChanged: (value) {}),
            const Text('Family'),
            Radio(value: 'Facebook', groupValue: null, onChanged: (value) {}),
            const Text('Facebook'),
            Radio(value: 'Google', groupValue: null, onChanged: (value) {}),
            const Text('Google'),
            Radio(value: 'Others', groupValue: null, onChanged: (value) {}),
            const Text('Others'),
          ],
        ),
      ],
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: ServiceRequestScreen(),
  ));
}

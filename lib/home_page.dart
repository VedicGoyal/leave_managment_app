import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class LeaveApplicationHomePage extends StatefulWidget {
  const LeaveApplicationHomePage({super.key});

  @override
  State<LeaveApplicationHomePage> createState() => _LeaveApplicationHomePageState();
}

class _LeaveApplicationHomePageState extends State<LeaveApplicationHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _designationController = TextEditingController();
  final _departmentController = TextEditingController();
  final _positionsController = TextEditingController();
  final _leaveTypeController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _numberOfDaysController = TextEditingController();
  bool _hasClass = false;
  bool _hasInvigilationDuty = false;
  bool _hasAdministrativeDuty = false;
  final List<ClassReschedule> _classesToReschedule = [];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _employeeIdController.dispose();
    _designationController.dispose();
    _departmentController.dispose();
    _positionsController.dispose();
    _leaveTypeController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    _numberOfDaysController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)))!;
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Application'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'FACULTY Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Apply Leave'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Leave Log'),
              onTap: () {
                Navigator.pushNamed(context, '/leave-log');
              },
            ),
            ListTile(
              leading: const Icon(Icons.approval),
              title: const Text('Approve Request'),
              onTap: () {
                Navigator.pushNamed(context, '/approve-request');
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Back to dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Text(
                'Apply for leave',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('Fill out this form for seamless leave approval!'),
              const SizedBox(height: 20),
              _buildTextField('Username', _nameController),
              _buildTextField('Email', _emailController),
              _buildTextField('Employee ID', _employeeIdController),
              _buildTextField('Designation', _designationController),
              _buildTextField('Department', _departmentController),
              _buildTextField('Positions', _positionsController),
              _buildDropdownField('Leave Type', _leaveTypeController, ['PL/EL','CL', 'CCL', 'ODL', 'Special CL']),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fromDateController,
                      decoration: const InputDecoration(labelText: 'From Date'),
                      onTap: () => _selectDate(context, _fromDateController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter from date';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _toDateController,
                      decoration: const InputDecoration(labelText: 'To Date'),
                      onTap: () => _selectDate(context, _toDateController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter to date';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              _buildTextField('Number of Days', _numberOfDaysController),
              _buildSwitchTile('Do you have a class on the date(s) of leave?', _hasClass, (value) {
                setState(() {
                  _hasClass = value;
                });
              }),
              if (_hasClass) _buildClassRescheduleSection(),
              _buildSwitchTile('Do you have any invigilation duty during the leave period?', _hasInvigilationDuty, (value) {
                setState(() {
                  _hasInvigilationDuty = value;
                });
              }),
              _buildSwitchTile('Do you have any administrative duty during the leave period?', _hasAdministrativeDuty, (value) {
                setState(() {
                  _hasAdministrativeDuty = value;
                });
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Leave Application Submitted')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label, TextEditingController controller, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: controller.text.isEmpty ? null : controller.text,
      onChanged: (newValue) {
        setState(() {
          controller.text = newValue!;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildClassRescheduleSection() {
    return Column(
      children: [
        for (var i = 0; i < _classesToReschedule.length; i++) _buildClassRescheduleRow(i),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _classesToReschedule.add(ClassReschedule());
            });
          },
          child: const Text('Add Classes'),
        ),
      ],
    );
  }

  Widget _buildClassRescheduleRow(int index) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _classesToReschedule[index].dateController,
            decoration: const InputDecoration(labelText: 'Reschedule Date'),
            onTap: () => _selectDate(context, _classesToReschedule[index].dateController),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter reschedule date';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: _classesToReschedule[index].reasonController,
            decoration: const InputDecoration(labelText: 'Reason'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter reason';
              }
              return null;
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _classesToReschedule.removeAt(index);
            });
          },
        ),
      ],
    );
  }
}

class ClassReschedule {
  final dateController = TextEditingController();
  final reasonController = TextEditingController();
}

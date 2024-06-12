import 'package:flutter/material.dart';

class SegmentedControlWidget extends StatefulWidget {
  const SegmentedControlWidget({super.key});

  @override
  _SegmentedControlWidgetState createState() => _SegmentedControlWidgetState();
}

class _SegmentedControlWidgetState extends State<SegmentedControlWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSegmentedControlButton(0, "Button 1"),
        _buildSegmentedControlButton(1, "Button 2"),
        _buildSegmentedControlButton(2, "Button 3"),
      ],
    );
  }

  Widget _buildSegmentedControlButton(int index, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        label: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
        ),
        selected: _selectedIndex == index,
        selectedColor: Colors.blue,
        onSelected: (selected) {
          setState(() {
            _selectedIndex = selected ? index : -1;
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Segmented Control Widget Example'),
      ),
      body: Center(
        child: SegmentedControlWidget(),
      ),
    ),
  ));
}

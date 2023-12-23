import 'package:flutter/material.dart';

class UserTypeSelection extends StatefulWidget {
  String selectedUserType = 'customer';
  @override
  UserTypeSelectionState createState() => UserTypeSelectionState();
 
}

class UserTypeSelectionState extends State<UserTypeSelection> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.selectedUserType = 'customer';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: widget.selectedUserType == 'customer'
                      ? Colors.orange[800]
                      : Colors.white,
                ),
                child: Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      'Customer',
                      style: TextStyle(
                        color: widget.selectedUserType == 'customer'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.selectedUserType = 'deliveryman';
             
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: widget.selectedUserType == 'deliveryman'
                      ? Colors.orange[800]
                      : Colors.white,
                ),
                child: Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      'Delivery Man',
                      style: TextStyle(
                        color: widget.selectedUserType == 'deliveryman'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text('Selected Type: ${widget.selectedUserType}'),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

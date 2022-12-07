import 'package:api_integration_demo/models/users_data_model.dart';
import 'package:api_integration_demo/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UsersData> userDataList = []; // empty list to add user data
  bool isLoading = false; // boolean variable to show loader
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// to call service to get user data as page gets loaded
    getData();
  }

  getData() async {
    try {
      isLoading = true;
      // calling the service and adding response to user data list
      userDataList.addAll(await UserService().getUserData());
      isLoading = false;
      setState(() {}); //to change the state after receiving the response
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: userDataList.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.blueAccent.shade400,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: [
                    _rowData("Name", "${userDataList[index].name}"),
                    _rowData("Username", "${userDataList[index].username}"),
                    _rowData("Email", "${userDataList[index].email}"),
                    _rowData("Phone", "${userDataList[index].phone}"),
                    _rowData("Website", "${userDataList[index].website}"),
                    _rowData("Company", "${userDataList[index].company?.name}"),
                    _rowData("Address",
                        "${userDataList[index].address?.street}/${userDataList[index].address?.suite}/${userDataList[index].address?.city}/${userDataList[index].address?.zipcode}")
                  ],
                ),
              ),
            ),
    );
  }

  /// functional widget to display the data in row format
  _rowData(String title, String value) {
    return Row(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )),
        const Text(
          ":  ",
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                value,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.w300, color: Colors.white),
              )),
        ),
      ],
    );
  }
}

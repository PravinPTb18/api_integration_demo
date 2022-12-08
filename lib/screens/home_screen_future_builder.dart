/// This is the code to display list of users data using future builder

import 'package:flutter/material.dart';
import '../models/users_data_model.dart';
import '../services/user_service.dart';

class HomeScreenFutureBuilder extends StatefulWidget {
  const HomeScreenFutureBuilder({super.key});

  @override
  State<HomeScreenFutureBuilder> createState() =>
      _HomeScreenFutureBuilderState();
}

class _HomeScreenFutureBuilderState extends State<HomeScreenFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen (future builder)"),
      ),
      body: FutureBuilder<List<UsersData>>(
          future: UserService().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                return _listOfUsersData(snapshot);
              } else {
                return const Center(child: Text("No data to display..."));
              }
            }
            return Text(snapshot.connectionState.toString());
          }),
    );
  }

  /// display a list
  _listOfUsersData(AsyncSnapshot<List<UsersData>> usersData) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: usersData.data!.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: Colors.blueAccent.shade400,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            _rowData("Name", "${usersData.data![index].name}"),
            _rowData("Username", "${usersData.data![index].username}"),
            _rowData("Email", "${usersData.data![index].email}"),
            _rowData("Phone", "${usersData.data![index].phone}"),
            _rowData("Website", "${usersData.data![index].website}"),
            _rowData("Company", "${usersData.data![index].company?.name}"),
            _rowData("Address",
                "${usersData.data![index].address?.street}/${usersData.data![index].address?.suite}/${usersData.data![index].address?.city}/${usersData.data![index].address?.zipcode}")
          ],
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

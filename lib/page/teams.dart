// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';

import '../func/fetchTeam.dart';



class NbaTeamsList extends StatefulWidget {
  @override
  _NbaTeamsListState createState() => _NbaTeamsListState();
}

class _NbaTeamsListState extends State<NbaTeamsList> {
  late Future<List<dynamic>> futureNbaTeams;


  @override
  void initState() {
    super.initState();
    futureNbaTeams = fetchNbaTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NBA Teams'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: futureNbaTeams,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data![index]['full_name']),
                      subtitle: Text(snapshot.data![index]['city']),
                      leading:Image.network(
                    'https://raw.githubusercontent.com/TGOlson/nba-logos/main/data/img/team/${snapshot.data![index]['abbreviation']}_2022.png',
                    height: 40,
                    width: 40,)
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

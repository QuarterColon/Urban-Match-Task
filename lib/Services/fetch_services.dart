import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchServices {
  final BuildContext context;
  const FetchServices({required this.context});

  Future<List> fetchRepos() async {
    try {
      http.Response response = await http.get(Uri.parse("https://api.github.com/users/freeCodeCamp/repos"), headers: {
      });

      List data = jsonDecode(response.body);

      return data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }

  Future<List> fetchCommits(String fullname) async {
    try {
      http.Response response = await http.get(Uri.parse("https://api.github.com/repos/${fullname}/commits"), headers: {
      });

      List data = jsonDecode(response.body);

      return [data[0], data.length];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }

  Future<List> fetchCodeChanges(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
      });

      Map data = jsonDecode(response.body);
      return data["files"];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_assignment6/constants/colors.dart';
import 'package:flutter_assignment6/models/note.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes=[];

  @override
  void initState(){
    super.initState();
    filteredNotes=sampleNotes;
  }
  getRandomColor(){
    Random random=Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];

  }

  void onSearchTextChanged(String searchText){
    setState(() {
      filteredNotes = sampleNotes
          .where((note) => note.content.toLowerCase().contains(searchText.toLowerCase()) ||
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Notes', style:TextStyle(fontSize: 30, color: Colors.white),),
                IconButton(onPressed: (){},
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.grey.shade800.withOpacity(.8),
                        borderRadius:BorderRadius.circular(10)),
                        child: Icon(
                          Icons.sort,
                          color: Colors.white,
                        )
                    )
                )
              ],
            ),
            SizedBox(height: 20,),

            TextField(
              onChanged: onSearchTextChanged,

              style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintStyle: const TextStyle(color: Colors.grey) ,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)
                )
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: filteredNotes.length,
              itemBuilder: (context, index){
                    return Card(
                      color: getRandomColor(),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: '${filteredNotes[index].title} \n',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight:FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                      text: filteredNotes[index].content,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          height: 1.5
                                      )
                                  )
                                ]
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text(
                              '${DateFormat('EEE MMM d, YYYY h:mm a').format(filteredNotes[index].modifiedTime)}',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey.shade800
                              ),
                            ),
                          ),

                          trailing: IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ),
                    );
              },
            ))
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }
}

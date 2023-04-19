import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/Service/Auth_Service.dart';
import 'package:todo/pages/add_todo.dart';
import 'package:todo/pages/profile_page.dart';
import 'package:todo/pages/signUp_page.dart';
import 'package:todo/pages/todo_card.dart';
import 'package:todo/pages/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Authclass authclass = Authclass();

  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('Todo').snapshots();

  List<Select> selected = [];

  void onChange(int index) {
    setState(() {
      selected[index].checkvalue = !selected[index].checkvalue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          SizedBox(width: 20)
        ],
        // bottom: const PreferredSize(
        //   preferredSize: Size.fromHeight(35),
        //   child: Align(
        //     alignment: Alignment.centerLeft,
        //     child: Padding(
        //       padding: EdgeInsets.only(left: 22),
        //       child: Text(
        //         'Monday 21',
        //         style: TextStyle(
        //             fontSize: 30,
        //             fontWeight: FontWeight.w500,
        //             color: Colors.purpleAccent),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const ProfilePage()));
              },
              child: const Icon(
                Icons.person,
                size: 32,
                color: Colors.white,
              ),
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const AddToDoPage()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Colors.purple],
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () async {
                await authclass.logout();

                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const SignUpPage()),
                    (route) => false);
              },
              child: const Icon(
                Icons.logout,
                size: 32,
                color: Colors.white,
              ),
            ),
            label: 'Log Out',
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              IconData iconData;
              //Converting Data from Json to Map
              Map<String, dynamic> document =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              switch (document['category']) {
                case 'Run':
                  iconData = Icons.run_circle_outlined;
                  break;
                case 'Workout':
                  iconData = Icons.fitness_center;
                  break;
                case 'Food':
                  iconData = Icons.local_grocery_store;
                  break;
                case 'Work':
                  iconData = Icons.work;
                  break;
                case 'Design':
                  iconData = Icons.design_services;
                  break;
                default:
                  iconData = Icons.circle;
              }
              selected.add(
                  Select(id: snapshot.data!.docs[index].id, checkvalue: false));
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => ViewData(
                        document: document,
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: ToDoCard(
                  title:
                      document['title'] == '' ? 'No Title' : document['title'],
                  iconData: iconData,
                  time: '10.30 am',
                  check: selected[index].checkvalue,
                  index: index,
                  onChange: onChange,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Select {
  String id;
  bool checkvalue = false;
  Select({required this.id, required this.checkvalue});
}

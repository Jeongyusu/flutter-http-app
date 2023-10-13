import 'package:flutter/material.dart';
import 'package:flutter_http_app/model/user.dart';
import 'package:flutter_http_app/repository/user_repopsitory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserListPage(),
    );
  }
}

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        //퓨처빌더 - 그림을 미리 그리기 위해서
        future: UserRepository().fetchUserList(),
        builder: (context, snapshot) {
          print("그림 그려짐!!!!!!!!!!!!!!");
          if (snapshot.hasData) {
            // 통신이 끝남
            List<User> userList = snapshot.data ?? [];
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${userList[index].id}"),
                  title: Text("${userList[index].username}"),
                  subtitle: Text("${userList[index].email}"),
                );
              },
            );
          } else {
            // 통신중인 상태
            return Center(
                child: Image.asset(
              "assets/kakao.gif",
              fit: BoxFit.cover,
            ));
          }
        },
      ),
    );
  }
}

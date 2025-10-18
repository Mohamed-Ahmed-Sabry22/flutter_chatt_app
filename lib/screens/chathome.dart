import 'package:_8_chat_app/constants.dart';
import 'package:_8_chat_app/models/message.dart';
import 'package:_8_chat_app/widgets/chatbuble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatHome extends StatelessWidget {
  static String id = 'home';
  CollectionReference messeges = FirebaseFirestore.instance.collection(
    kMessegeCollections,
  );
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messeges.orderBy(kCreatedAt).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _controller.animateTo(
                _controller.position.maxScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeIn,
              );
            }
          });
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, i) {
                      return messagesList[i].id == email
                          ? ChatBuble(msg: messagesList[i])
                          : ChatBubleForFriend(msg: messagesList[i]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messeges.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                    },
                    style: TextStyle(fontSize: 12.0),
                    cursorColor: const Color.fromARGB(255, 97, 96, 96),
                    cursorHeight: 18,
                    decoration: InputDecoration(
                      hintText: "Send Messege",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 20, 20, 20),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 6.0,
                          top: 6,
                          bottom: 6,
                        ),
                        child: InkWell(
                          onTap: () {
                            messeges.add({
                              kMessage: controller.text,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            });
                            controller.clear();
                          },
                          child: Container(
                            // height: 30,
                            width: 40,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular((15)),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

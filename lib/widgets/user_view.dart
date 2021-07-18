import 'package:flutter/material.dart';
import 'custom_container.dart';
import '../models/user.dart';
import 'package:mdi/mdi.dart';

class UserView extends StatelessWidget {
  final User user;
  UserView(this.user);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (user.instagram != null)
                        Row(
                          children: [
                            Icon(
                              Mdi.instagram,
                              color: Colors.cyan,
                            ),
                            SizedBox(width: 3),
                            Container(
                              constraints: user.twitter != null
                                  ? BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.25)
                                  : BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6),
                              child: Text(user.instagram.toString()),
                            ),
                          ],
                        ),
                      if (user.twitter != null)
                        Row(
                          children: [
                            Icon(
                              Mdi.twitter,
                              color: Colors.cyan,
                            ),
                            SizedBox(width: 3),
                            Container(
                              constraints: user.instagram != null
                                  ? BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.25)
                                  : BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6),
                              child: Text(user.twitter.toString()),
                            ),
                          ],
                        )
                    ]),
              ],
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 30,
            child: ClipOval(
              child: Image.network(
                user.image.toString(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CircularProgressIndicator();
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Text(
                    'Couldn\'t load the image',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

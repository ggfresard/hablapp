import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hablapp/screens/landing.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = 'chat-page';

  final FirebaseUser user;

  const ChatPage({Key key, this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  static ScrollController scrollController = ScrollController();

  bool _isInit = false;





  @override
  void didChangeDependencies() {
      if(_isInit){
         scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 300),
        );
        _isInit = false;
        
      }
      super.didChangeDependencies();

    
   }

   



  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _firestore.collection('messages').add({
        'text': messageController.text,
        'from': widget.user.email,
        'dateTime': DateTime.now().toIso8601String()
      });
        messageController.clear();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 300),
        );
      
    }
  }

  void toBottom(){

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandingPage(),), (route) => false);
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
        ],
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo.png'),
            ),
          ),
        ),
        title: Text(
          'Hablapp',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                
                stream: _firestore.collection('messages').snapshots(),
                builder: (ctx, snapshot) {

                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  docs.sort((b,a) => DateTime.parse(a.data['dateTime']).compareTo(DateTime.parse(b.data['dateTime'])));
                  List<Widget> messages = [];
                  for(int i = 0;i< docs.length; i++){
                    messages.insert(0,Message(
                            from: docs[i].data['from'],
                            text: docs[i].data['text'],
                            me: docs[i].data['from'] == widget.user.email,
                            isLast: i==docs.length -1 ? true: false,
                            scrollController: scrollController,
                          ));

                  }
                

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
                },
              ),
            ),
            Card(
              elevation: 8,
              color: Theme.of(context).primaryColor,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          minLines: 1,
                          maxLines: 6,
                          controller: messageController,
                          cursorColor: Theme.of(context).accentColor,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontFamily: "Comfortaa"),
                        ),
                      ),
                    ),
                    SendButton(
                      text: "",
                      callback: callback,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      height: 40,
      child: RaisedButton(
        elevation: 6,
        shape: CircleBorder(),
        onPressed: callback,
        child: Icon(
          Icons.send,
          color: Theme.of(context).primaryColor,
        ),
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final ScrollController scrollController;
  final bool isLast;

  final bool me;

  const Message({Key key, this.from, this.text, this.me, this.scrollController, this.isLast}) : super(key: key);

  @override
  void initState() {
  SchedulerBinding.instance
                .addPostFrameCallback((_){
                  scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 300));
        print("gola");
                });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          //Text(from),
          Material(
            color: me
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            elevation: 6,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Text(
                text,
                style: TextStyle(
                    color: me
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Mesaj tarih ve saat formatı için

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage(String type) {
    if (_messageController.text.trim().isNotEmpty || type != 'text') {
      setState(() {
        _messages.insert(0, {
          'text': _messageController.text.trim(),
          'isSentByMe': true,
          'type': type,
          'timestamp': DateTime.now(),
        });
      });
      _messageController.clear();
    }
  }

  void _addReaction(int index, String reaction) {
    setState(() {
      if (!_messages[index].containsKey('reaction')) {
        _messages[index]['reaction'] = reaction;
      } else {
        _messages[index]['reaction'] = null; // Reaksiyonu kaldır
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sohbet'),
        backgroundColor: Color(0xFF2C5364),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Daha fazla seçenek')), // İsteğe bağlı menü
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Mesajlar Listesi
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSentByMe = message['isSentByMe'] as bool;
                final type = message['type'] as String;
                final timestamp = message['timestamp'] as DateTime;
                final reaction = message['reaction'];

                return Align(
                  alignment:
                      isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: GestureDetector(
                    onLongPress: () {
                      _addReaction(index, '👍');
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color:
                            isSentByMe ? Color(0xFF203A43) : Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: isSentByMe
                              ? Radius.circular(12.0)
                              : Radius.circular(0),
                          bottomRight: isSentByMe
                              ? Radius.circular(0)
                              : Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (type == 'text')
                            Text(
                              message['text'],
                              style: TextStyle(
                                color:
                                    isSentByMe ? Colors.white : Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          SizedBox(height: 6.0),
                          Text(
                            DateFormat('hh:mm a').format(timestamp),
                            style: TextStyle(
                              color:
                                  isSentByMe ? Colors.white70 : Colors.black54,
                              fontSize: 12.0,
                            ),
                          ),
                          if (reaction != null)
                            Text(
                              'Reaksiyon: $reaction',
                              style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    isSentByMe ? Colors.yellow : Colors.orange,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: Color(0xFF2C5364)),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Mesajınızı yazın...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF2C5364)),
                  onPressed: () => _sendMessage('text'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

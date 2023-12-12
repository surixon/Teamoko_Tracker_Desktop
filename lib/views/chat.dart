import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:desk/base/base_view.dart';
import 'package:desk/components/chat_attachment_dialog.dart';
import 'package:desk/data/socket_io_manager.dart';
import 'package:desk/model/all_messages.dart';
import 'package:desk/model/chat_screen_arguments.dart';
import 'package:desk/model/message.dart';
import 'package:desk/model/send_message_request.dart';
import 'package:desk/model/typing_data.dart';
import 'package:desk/provider/messages_provider.dart';
import 'package:desk/res/decoration.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/utils.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  ChatScreenArguments arguments;

  ChatScreen({this.arguments});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController;
  SocketIoManager socketIoManager = GetIt.instance.get();
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  MessagesProvider _provider;
  var textController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  File _imageFile;
  String imageName;
  String _eventName;

  bool isOnline = false;
  String _userNameTyping;
  String _toUserId = '';
  String _eventStatus = '';
  String _toUserName = '';
  String _toUserContact = '';
  String _toProfilePic = '';
  String _chatType = '';
  String _groupId;
  String _eventId;
  int currentPage = 1;
  int lastPage = 1;
  bool isGroupchat = false;

  static const List<String> choices = <String>[
    "Complete",
    "Cancel",
    "Pass Task",
  ];

  void _isTypingEmit(String typing) {
    // 1 for start typing
    // 0 for stop typing
    var data = {
      'username': _sharedPreferences.getString(userName),
      'group_id': _groupId,
      'isTyping': typing,
      'chat_type': _chatType.isEmpty ? '' : _chatType,
    };

    print(data);
    socketIoManager.socket.emit('is_typing', data);
  }

  void _sendMessage(String messageType, String messageContent, bool isCenter,
      String colorCode) {
    var data = {
      "user_id": _sharedPreferences.getString(userId),
      "username": _sharedPreferences.getString(userName),
      "message": messageContent,
      "msg_type": messageType,
      "is_center": isCenter,
      "msg_color": colorCode,
      "to_user_id": _toUserId,
      "contact": _sharedPreferences.getString(phoneNumber),
      "chat_type": (_chatType == "2" || _chatType == "3") ? _chatType : '',
      "is_seen": isOnline ? '1' : '0',
      "group_id": _groupId,
      "thumbnail": '',
      "profile_pic": '',
      "datetime": (DateTime.now().millisecondsSinceEpoch),
    };

    if (messageType == "T") {
      data.addAll({
        "otherUserId": _toUserId,
        "otherUserContact": _toUserContact,
        "otherUserName": _toUserName
      });
    } else if (messageType == 'I') {
      data.addAll({
        "imageName": imageName,
      });
    }

    print('SendMessage' + "   " + jsonEncode(data));
    socketIoManager.socket.emit('chatmessage', data);

    var message = SendMessage.fromJson(json.decode(jsonEncode(data)));
    Output output = Output(
        id: '',
        userId: message.userId,
        username: message.username,
        contact: message.contact,
        groupId: message.groupId,
        chatType: message.chatType,
        message: message.message,
        msgType: message.msgType,
        images: '',
        isDownload: '',
        datetime: message.datetime,
        isCenter: message.isCenter.toString(),
        msgColor: message.msgColor,
        isSeen: message.isSeen,
        imageName: '',
        thumbnail: message.thumbnail,
        duration: ' ',
        otherUserId: message.otherUserId,
        otherUserContact: message.otherUserContact);
    _provider.addMessage(output);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    socketIoManager.socket.on('postchat', (data) {
      var allMessages = allMessagesFromJson(jsonEncode(data));
      print(jsonEncode(data));
      print("CurrentPage" + "   " + allMessages.currentPage.toString() + "  ");
      currentPage = int.parse(allMessages.currentPage);
      lastPage = allMessages.lastPage;
      _provider.addAllPreviousMessage(allMessages.output);
    });

    socketIoManager.socket.on('messages', (data) {
      print("New Message" + jsonEncode(data));
      var message = Message.fromJson(json.decode(jsonEncode(data)));
      Output output = Output(
          id: message.id.toString(),
          userId: message.userId,
          username: message.username,
          contact: message.contact,
          groupId: message.groupId,
          chatType: message.chatType,
          message: message.message,
          msgType: message.msgType,
          images: message.images,
          isDownload: message.isDownload,
          datetime: message.datetime,
          isCenter: message.isCenter.toString(),
          msgColor: message.msgColor,
          isSeen: message.isSeen,
          imageName: message.imageName,
          thumbnail: message.thumbnail,
          duration: ' ',
          otherUserId: message.otherUserId,
          otherUserContact: message.otherUserContact);
      _provider.addMessage(output);
    });

    socketIoManager.socket.on('typing', (data) {
      print("Typing" + "  " + jsonEncode(data));
      var typingData = TypingData.fromJson(jsonDecode(jsonEncode(data)));
      _provider.notifyIsTyping(typingData, _groupId);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    socketIoManager.socket.off('postchat');
    socketIoManager.socket.off('messages');
    socketIoManager.socket.off('typing');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()..init(context);
    return Scaffold(
      /*appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.arguments.userName,
          style: TextStyle(color: Colors.black),
        ),
      ),*/
      backgroundColor: Colors.grey.shade300,
      body: BaseView<MessagesProvider>(
          onModelReady: (provider) {
            _provider = provider;

            if (widget.arguments.eventid.isNotEmpty) {
              _eventId = widget.arguments.eventid;
              _groupId = _eventId;
              _provider
                  .getTaskDetail(
                      context,
                      _eventId,
                      _sharedPreferences.getString(companyId),
                      _sharedPreferences.getString(userId))
                  .then((value) {
                if (value) onEventDetailSuccessfully();
              });
            } else {
              _createGroupIdAndSetData();
              socketIoManager.socket.emit('getchat', {
                "user_id": _sharedPreferences.getString(userId),
                "g_id": _groupId,
                "pageno": currentPage.toString(),
                "chat_type": _chatType
              });
            }
          },
          builder: (context, provider, _) => Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      userName: _toUserName??'',
                      userProfile: _toProfilePic,
                      eventName: _eventName??'',
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (currentPage < lastPage &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            print('Top');
                            socketIoManager.socket.emit('getchat', {
                              "user_id": _sharedPreferences.getString(userId),
                              "g_id": _groupId,
                              "pageno": (currentPage + 1).toString(),
                              "chat_type": _chatType
                            });
                          }
                          return;
                        },
                        child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: provider.allMessages.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: provider.allMessages[index].userId ==
                                          _sharedPreferences.getString(userId)
                                      ? sendMessageWidget(
                                          scaler, provider.allMessages[index])
                                      : recieveMessage(
                                          scaler, provider.allMessages[index]));
                            }),
                      ),
                    ),
                    Visibility(
                      visible: _provider.isTyping,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$_toUserName is typing',
                              style: Theme.of(context).textTheme.titleLarge.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Lottie.asset(
                              'assets/animations/chat_typing_indicator.json',
                              width: 24,
                              height: 24,
                              alignment: Alignment.bottomLeft,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(0, 0, 0, 0),
                      child: Container(

                     /*   decoration: BoxDecoration(
                            border:
                                Border.all(color: CommonColors.primaryColor),
                            color: Colors.white,
                            borderRadius: scaler.getBorderRadiusCircular(12)),*/
                        child: Padding(
                          padding: scaler.getPaddingLTRB(0.0, 0, 0.5, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ChatAttachmentDialog(
                                            cameraClick: () {},
                                            galleryClick: () {
                                              selectImage();
                                            },
                                            cancelClick: () {
                                              Navigator.of(context).pop();
                                            },
                                          ));
                                },
                                icon: Icon(
                                  Icons.add_circle_outline_sharp,
                                  color: Colors.grey,
                                  size: 36,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  maxLines: 5,
                                  controller: textController,
                                  minLines: 1,
                                  onChanged: (v) {
                                    if (v.trim().isEmpty) {
                                      provider.updateSendMessageState(false);
                                      _isTypingEmit("0");
                                    } else {
                                      provider.updateSendMessageState(true);
                                      _isTypingEmit("1");
                                    }
                                  },
                                  keyboardType: TextInputType.multiline,
                                  style: ViewDecoration.textStyleRegular(
                                      Colors.black, scaler.getTextSize(10)),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(4.0),
                                      border: InputBorder.none,
                                      hintStyle:
                                          ViewDecoration.textStyleRegular(
                                              Colors.black54,
                                              scaler.getTextSize(10)),
                                      hintText: "Type your messsage here...."),
                                ),
                              ),
                              /*  Icon(Icons.mic,color: Colors.black,),*/
                              provider.sendMessageState
                                  ? GestureDetector(
                                      onTap: () {
                                        _sendMessage(
                                            'T',
                                            textController.text.toString(),
                                            false,
                                            '');
                                        textController.text = "";
                                        provider.updateSendMessageState(false);
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Container(
                                      width: 1,
                                    ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
    );
  }

  void _createGroupIdAndSetData() {
    if (widget.arguments.userId.isNotEmpty) {
      _toUserId = widget.arguments.userId;
      _toUserName = widget.arguments.userName;
      _toUserContact = widget.arguments.contact;
      _toProfilePic = widget.arguments.profileUrl;
      _chatType = '2';

      if (int.parse(_toUserId) <
          int.parse(_sharedPreferences.getString(userId))) {
        _groupId = _toUserId + "-" + _sharedPreferences.getString(userId);
      } else {
        _groupId = _sharedPreferences.getString(userId) + "-" + _toUserId;
      }
    }
  }

  Widget recieveMessage(ScreenScaler scaler, Output messageDetail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: <Widget>[
          Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                getWidgetType(messageDetail, scaler, 1),
                Text(
                  Utils.getFormattedDateTimeFromTimeStamp(
                      messageDetail.datetime),
                  textAlign: TextAlign.right,
                  style: ViewDecoration.textStyleRegular(
                      Colors.black, scaler.getTextSize(7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sendMessageWidget(ScreenScaler scaler, Output messageDetail) {
    return Bubble(
      margin: BubbleEdges.only(top: 10, bottom: 2),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      color: CommonColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          getWidgetType(messageDetail, scaler, 0),
          Text(
            Utils.getFormattedDateTimeFromTimeStamp(messageDetail.datetime),
            textAlign: TextAlign.right,
            style: ViewDecoration.textStyleRegular(
                Colors.white, scaler.getTextSize(7)),
          ),
        ],
      ),
    );
  }

  Widget getWidgetType(Output messageDetail, ScreenScaler scaler, int type) {
    if (messageDetail.msgType == 'I') {
      print(messageDetail.message);
      return Image.network(
        messageDetail.message,
        width: scaler.getWidth(20),
        height: scaler.getWidth(20),
        fit: BoxFit.cover,
      );
    } else if (messageDetail.msgType == 'A') {
      return Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.not_started,
                color: CommonColors.darkGrey,
              ),
              onPressed: () async {
                int result = await audioPlayer.play(messageDetail.message);
                if (result == 1) {
                  // success
                }
              }),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: 140.0,
              lineHeight: 14.0,
              percent: 0.5,
              center: Text(
                "50.0%",
                style: new TextStyle(fontSize: 12.0),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ),
        ],
      );
    } else {
      return Text(
        messageDetail.message,
        textAlign: TextAlign.right,
        style: ViewDecoration.textStyleRegular(
            type == 0 ? Colors.white : Colors.black, scaler.getTextSize(9)),
      );
    }
  }

  Future<void> selectImage() async {
    Navigator.of(context).pop();
    FilePickerCross file = await FilePickerCross.importFromStorage(
        type: FileTypeCross.custom,
        // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            'png,jpeg,jpg' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
        );
    var path = file.path;
    _imageFile = File('$path');
    _provider.uploadFile(context, _imageFile).then((value) {
      imageName = value.response.imageName;
      _sendMessage('I', value.response.data, false, '');
    });
  }

  void onEventDetailSuccessfully() {
    if (_sharedPreferences.getString(userId) == _provider.taskDetail.toUserId) {
      _toUserId = _provider.taskDetail.userId;
    } else {
      _toUserId = _provider.taskDetail.toUserId;
    }

    _eventStatus = _provider.taskDetail.status;
    _eventName = _provider.taskDetail.eventName;

    if (_provider.taskDetail.isGroupchat == '1') {
      _toUserName = _provider.taskDetail.groupName;
      isGroupchat = true;
    } else {
      _toUserName = _provider.taskDetail.toUser;
      if (_provider.taskDetail.userId == _sharedPreferences.getString(userId)) {
        _toUserName = _provider.taskDetail.toUser;

        if (_provider.taskDetail.receiverProfilePic.isNotEmpty) {
          _toProfilePic = _provider.taskDetail.receiverProfilePic;
        } else {
          _toProfilePic = _provider.taskDetail.senderProfilePic;
        }
      }

      socketIoManager.socket.emit('getchat', {
        "user_id": _sharedPreferences.getString(userId),
        "g_id": _groupId,
        "pageno": currentPage.toString(),
        "chat_type": _chatType
      });
    }
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size preferredSize;

  String userName;
  String userProfile;
  String eventName;

  CustomAppBar({this.userName, this.userProfile, this.eventName})
      : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 0.75))
      ], color: Colors.white),
      child: Row(
        children: [
          SizedBox(
            width: 8.0,
          ),
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          SizedBox(
            width: 8.0,
          ),
          Center(
              child: userProfile.isEmpty
                  ? Container()
                  : CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(userProfile),
                    )),
          SizedBox(
            width: 4.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(color: Colors.black)),
              Text(eventName, style: TextStyle(color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }
}

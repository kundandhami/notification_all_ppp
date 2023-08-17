import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';

class Downloader extends StatefulWidget {
  const Downloader({Key? key}) : super(key: key);

  @override
  State<Downloader> createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader> {
  final TextEditingController imageController = TextEditingController(text: "");
  final TextEditingController videoController = TextEditingController(text: "");

  final MethodChannel channel = MethodChannel("videoDownloader");
  late ScrollController controller;
  double offset = 0;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    controller = ScrollController(initialScrollOffset: offset);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      double newoffset = controller.offset + 50;

      if (offset != newoffset) {
        offset = newoffset;
        controller.animateTo(offset,
            duration: Duration(seconds: 1), curve: Curves.linear);
      } else {
        newoffset = 0;
        offset = newoffset;
        controller.animateTo(offset,
            duration: Duration(seconds: 1), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 120,
                    color: index % 2 == 0 ? Colors.amber : Colors.purpleAccent,
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isExpanded ? 350 : 70,
                  width: double.maxFinite,
                  color: Colors.blue,
                  padding: EdgeInsets.all(16.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: isExpanded
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Item 1'),
                                      Text('Item 3'),
                                      Text('Item 1'),
                                      Text('Item 3'),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star,
                                          size: 40.0, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        'Tap to Expand',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                      );
                    },
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  toggal = !toggal;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: toggal ? (11 * 82) - 21 : 72,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: Column(
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.purpleAccent,
                                ),
                                title: Text("hey"),
                                subtitle: Text("subtitle"),
                                trailing: Icon(Icons.arrow_forward_ios),
                                tileColor: Colors.amberAccent,
                              ),
                              if (toggal)
                                ...List.generate(
                                  10,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ListTile(
                                      onTap: () {
                                        log(index.toString());
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.purpleAccent,
                                      ),
                                      title: Text("$index"),
                                      subtitle: Text("subtitle"),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      tileColor: Colors.amberAccent,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
            TextField(
              controller: imageController,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  var perm = await [Permission.storage].request();
                  print("permission---$perm");
                  if (imageController.text != "") {
                    FileDownloader.downloadFile(
                      url: imageController.text.trim(),
                      onProgress: (fileName, progress) {
                        setState(() {
                          this.progress = progress;
                        });
                      },
                      onDownloadCompleted: (path) {
                        print("---path---$path");
                        setState(() {
                          progress = 0;
                        });
                      },
                    );
                  }
                  imageController.clear();
                },
                icon: Icon(Icons.download),
                label: Text("Download")),
            if (progress != 0)
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.black87,
                color: Colors.white,
              ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: videoController,
            ),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.download),
                label: Text("Download")),
            SizedBox(
              height: 20,
            ),
            Checkbox(
                value: checkBox,
                onChanged: (value) {
                  setState(() {
                    checkBox = value as bool;
                  });
                },
                // shape: OvalBorder(side: BorderSide(color: Colors.cyan)
                checkColor: Colors.pinkAccent,
                activeColor: Colors.amber,
                side: BorderSide(color: Colors.black87, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            Icon(Icons.notifications)
          ],
        ),
      ),
    );
  }

  double progress = 0;
  bool checkBox = false;

  bool toggal = false;
}

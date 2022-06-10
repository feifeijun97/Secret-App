import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

class ComicReaderScreen extends StatefulWidget {
  const ComicReaderScreen({Key? key}) : super(key: key);

  @override
  State<ComicReaderScreen> createState() => _ComicReaderScreenState();
}

class _ComicReaderScreenState extends State<ComicReaderScreen> {
  double brightness = 30;
  double page = 2;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _itemPositionsListener.itemPositions.addListener(() {
      int index = _itemPositionsListener.itemPositions.value.first.index + 1;
      if (index != page) {
        setState(() {
          page = index.toDouble();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = const [
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
    ];
    Widget floatingPanel({
      EdgeInsetsGeometry padding = EdgeInsets.zero,
      required Alignment alignment,
      List<Widget> children = const <Widget>[],
      BorderRadiusGeometry borderRadius = BorderRadius.zero,
      Color color = Colors.black,
    }) {
      return Align(
        alignment: alignment,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: color,
            ),
            child: Padding(
              padding: padding,
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            )),
      );
    }

    Widget iconButtonLabel(
        {required IconData icons,
        required String label,
        required void Function() onPressed}) {
      return InkWell(
        onTap: () => onPressed(),
        child: SizedBox(
          width: 15.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icons,
                size: 30,
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 11),
                textScaleFactor: 1,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(children: [
        // InkWell(
        //   onTap: () => print('clicked $brightness'),
        //   child: ListView.builder(
        //     physics: const AlwaysScrollableScrollPhysics(),
        //     itemCount: images.length,
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {},
        //   ),
        // ),
        // AnimatedList(
        //   initialItemCount: images.length,
        //   physics: const AlwaysScrollableScrollPhysics(),
        //   itemBuilder: ((context, index, animation) {
        //     return CachedNetworkImage(
        //       progressIndicatorBuilder: ((context, url, progress) => Center(
        //             child: SizedBox(
        //               width: 10.w,
        //               child: CircularProgressIndicator(
        //                 value: progress.progress,
        //                 backgroundColor: Colors.grey,
        //                 color: Colors.black,
        //               ),
        //             ),
        //           )),
        //       fit: BoxFit.fill,
        //       imageUrl: images[index],
        //       width: 100.w,
        //       height: 100.h,
        //     );
        //   }),
        // ),
        ScrollablePositionedList.builder(
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                progressIndicatorBuilder: ((context, url, progress) => Center(
                      child: SizedBox(
                        width: 10.w,
                        child: CircularProgressIndicator(
                          value: progress.progress,
                          backgroundColor: Colors.grey,
                          color: Colors.black,
                        ),
                      ),
                    )),
                fit: BoxFit.fill,
                imageUrl: images[index],
                width: 100.w,
                height: 100.h,
              );
            }),
        floatingPanel(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
          color: Colors.black87,
          children: [
            iconButtonLabel(
                icons: Icons.crop_landscape_outlined,
                label: "landscape".tr(),
                onPressed: () => print('建'.toUpperCase())),
            const SizedBox(height: 12),
            iconButtonLabel(
                icons: Elusive.resize_horizontal,
                label: "vertical".tr(),
                onPressed: () => print('page view')),
          ],
        ),
        floatingPanel(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          alignment: Alignment.centerLeft,
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(5)),
          color: Colors.black87,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Typicons.sun),
                  const SizedBox(width: 10),
                  SliderTheme(
                    data: SliderThemeData(
                        overlayShape: SliderComponentShape.noOverlay),
                    child: Slider(
                        autofocus: false,
                        label: "${brightness.toInt()}",
                        value: brightness,
                        min: 0,
                        max: 100,
                        onChanged: (value) => setState(() {
                              brightness = value.ceilToDouble();
                            }),
                        onChangeEnd: (value) => print(value)),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingPanel(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.topLeft,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
          color: Colors.black87,
          children: [
            SizedBox(
              width: 100.w,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.navigate_before),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Edition 1 : TIMES THEY ARE A CHANGIN\'',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingPanel(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          alignment: Alignment.bottomLeft,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
          color: Colors.black87,
          children: [
            SizedBox(
              width: 100.w,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () => _itemScrollController.jumpTo(index: 0),
                    child: const Icon(
                      FontAwesome.angle_double_left,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text('${page.toInt()}/${images.length}'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                          overlayShape: SliderComponentShape.noOverlay),
                      child: Slider(
                          autofocus: false,
                          label: "${page.toInt()}",
                          value: page,
                          min: 0,
                          max: images.length.toDouble(),
                          onChanged: (value) => setState(() {
                                page = value.ceilToDouble();
                              }),
                          onChangeEnd: (value) => print("change page")),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () =>
                        _itemScrollController.jumpTo(index: images.length - 1),
                    child: const Icon(
                      FontAwesome.angle_double_right,
                      size: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}

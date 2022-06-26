import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:gamaverse/features/comic_reader/bloc/comic_bloc.dart';
import 'package:gamaverse/features/comic_reader/widgets/bottom_loader.dart';
import 'package:gamaverse/utils/extensions/string_extension.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

class ComicPage extends StatelessWidget {
  const ComicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ComicBloc>(
            create: (context) => ComicBloc()..add(const FetchComic(id: '1'))),
      ],
      child: const ComicReaderScreen(),
    );
  }
}

class ComicReaderScreen extends StatefulWidget {
  const ComicReaderScreen({Key? key}) : super(key: key);

  @override
  State<ComicReaderScreen> createState() => _ComicReaderScreenState();
}

class _ComicReaderScreenState extends State<ComicReaderScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideTransitioncontroller;
  late Animation<Offset> _leftAnimation,
      _rightAnimation,
      _topAnimation,
      _bottomAnimation;
  bool visible = false;
  List<String> images = [];
  List<int> pages = [];
  double brightness = 30;
  int currentChapter = 0;
  double page = 1;
  double lastScrollPosition = 0, tempScrollPosition = 0;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  void animateToolkit() {
    if (!visible) {
      _slideTransitioncontroller.forward();
    } else {
      _slideTransitioncontroller.reverse();
    }
    setState(() {
      lastScrollPosition = tempScrollPosition;
      visible = !visible;
    });
  }

  void hideToolkit() {
    _slideTransitioncontroller.reverse();
    setState(() {
      visible = !visible;
    });
  }

  @override
  void initState() {
    super.initState();
    _slideTransitioncontroller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _leftAnimation = Tween<Offset>(
      begin: const Offset(-1, 0.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideTransitioncontroller,
      curve: Curves.linear,
    ));
    _rightAnimation = Tween<Offset>(
      begin: const Offset(1, 0.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideTransitioncontroller,
      curve: Curves.linear,
    ));
    _topAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideTransitioncontroller,
      curve: Curves.linear,
    ));
    _bottomAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideTransitioncontroller,
      curve: Curves.linear,
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemPositionsListener.itemPositions.addListener(() {
      double scrollPosition =
          _itemPositionsListener.itemPositions.value.first.itemLeadingEdge;
      tempScrollPosition = scrollPosition;
      //hide all floating panel when start scrolling
      if (lastScrollPosition != scrollPosition && visible) {
        hideToolkit();
        lastScrollPosition = scrollPosition;
      }
      //update the page's number rendering on the screen
      int index = _itemPositionsListener.itemPositions.value.first.index + 1;
      if (!visible && index != page) {
        setState(() => page = index.toDouble());
        if (pages.isNotEmpty) {
          setState(() {
            currentChapter =
                pages.lastIndexWhere((element) => page > element) + 1;
            page -= currentChapter > 0 ? pages[currentChapter - 1] : 0;
          });
        }

        // fetch next episod if scrolled to the end
        int lastIndex = _itemPositionsListener.itemPositions.value.last.index;
        if (lastIndex == images.length &&
            !BlocProvider.of<ComicBloc>(context).state.hasReachedLast) {
          BlocProvider.of<ComicBloc>(context).add(FetchComic(
              id: BlocProvider.of<ComicBloc>(context).state.nextEpisodId));
        }
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    _slideTransitioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget slideTransitionFloatingPanel({
      EdgeInsetsGeometry padding = EdgeInsets.zero,
      required Alignment alignment,
      List<Widget> children = const <Widget>[],
      BorderRadiusGeometry borderRadius = BorderRadius.zero,
      Color color = Colors.black,
      required Animation<Offset> position,
    }) {
      return SlideTransition(
        position: position,
        child: Align(
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
        ),
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
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () => print('$pages and $currentChapter')),
      body: BlocConsumer<ComicBloc, ComicState>(
        buildWhen: (previous, current) =>
            previous.comics.length != current.comics.length,
        listener: (context, state) {
          if (state.status == ComicStatus.failure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("failed to fetch comic".tr().capitalize()),
            ));
          }
        },
        builder: (context, state) {
          if (state.comics.isNotEmpty) {
            pages = state.pageCountList;
            images = state.comics.fold(
                [],
                (previousValue, element) =>
                    previousValue..addAll(element.imageUrls));
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => animateToolkit(),
                  onVerticalDragStart: (dragData) => print('dragData'),
                  child: ScrollablePositionedList.builder(
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                    itemCount: state.hasReachedLast
                        ? images.length
                        : images.length + 1,
                    itemBuilder: (context, index) {
                      return index >= images.length
                          ? BottomLoader()
                          : CachedNetworkImage(
                              progressIndicatorBuilder:
                                  ((context, url, progress) => Center(
                                        child: SizedBox(
                                          width: 10.w,
                                          child: CircularProgressIndicator(
                                            value: progress.progress ?? 0.0,
                                            backgroundColor: Colors.grey,
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                    Colors.black),
                                          ),
                                        ),
                                      )),
                              fit: BoxFit.fill,
                              imageUrl: images[index],
                              width: 100.w,
                              height: 100.h,
                            );
                    },
                  ),
                ),
                //right panel
                slideTransitionFloatingPanel(
                  position: _rightAnimation,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(5)),
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
                //left panel
                slideTransitionFloatingPanel(
                  position: _leftAnimation,
                  padding: const EdgeInsets.all(15),
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
                //top panel
                slideTransitionFloatingPanel(
                  position: _topAnimation,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  alignment: Alignment.topLeft,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(5)),
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
                          Text(
                            state.comics[currentChapter].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                //bottom panel
                slideTransitionFloatingPanel(
                  position: _bottomAnimation,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  alignment: Alignment.bottomLeft,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(5)),
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
                          Text(
                              '${page.toInt()}/${state.comics[currentChapter].pageCount}'),
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
                                  max: state.comics[currentChapter].pageCount
                                      .toDouble(),
                                  onChanged: (value) {
                                    setState(() => page = value.ceilToDouble());
                                    print(page);
                                  },
                                  onChangeEnd: (value) {
                                    _itemScrollController.scrollTo(
                                        duration: const Duration(seconds: 1),
                                        index: currentChapter > 0
                                            ? pages[currentChapter - 1] +
                                                page.toInt() -
                                                1
                                            : page.toInt() - 1);
                                  }),
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () => _itemScrollController.jumpTo(
                                index: images.length - 1),
                            child: const Icon(
                              FontAwesome.angle_double_right,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

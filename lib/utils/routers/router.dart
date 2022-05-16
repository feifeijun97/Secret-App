import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routers {
  static String root = "/";
  static String comicReader = "/comic_reader";
  // static String demoSimpleFixedTrans = "/demo/fixedtrans";
  // static String demoFunc = "/demo/func";
  // static String deepLink = "/message";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (context, params) {
        // print("ROUTE WAS NOT FOUND !!!");
        return;
      },
    );

    router.define(comicReader, handler: comicReaderHandler);

    // router.define(demoSimpleFixedTrans,
    //     handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
    // router.define(demoFunc, handler: demoFunctionHandler);
    // router.define(deepLink, handler: deepLinkHandler);
  }
}

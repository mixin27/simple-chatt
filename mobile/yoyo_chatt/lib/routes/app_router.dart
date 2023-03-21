import 'package:auto_route/auto_route.dart';
import 'package:yoyo_chatt/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: RegisterRoute.page, path: '/register'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: ChatListRoute.page, path: '/chat'),
    AutoRoute(page: ChatRoute.page, path: '/chat-screen'),
    AutoRoute(page: NewGroupRoute.page, path: '/chat/group/new'),
  ];
}

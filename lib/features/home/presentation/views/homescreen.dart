import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/widgets/apptext_formfield.dart';
import 'package:movies_app/features/auth/data/repos/authrepo.dart';
import 'package:movies_app/features/auth/presentation/views_model/auth_cubit/auth_cubit.dart';

import 'package:movies_app/features/home/data/repos/moviesrepository.dart';
import 'package:movies_app/features/home/presentation/views/widgets/popularview.dart';
import 'package:movies_app/features/home/presentation/views/widgets/searchresultview.dart';
import 'package:movies_app/features/home/presentation/views/widgets/trendingpage.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/movies_cubit.dart';

import '../../../favourites/presentation/views/favourites_screen.dart';
import '../views_model/cubit/search_cubit.dart';
import 'widgets/topratedpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedTabIndex = 0;
  int _selectedBottomNavIndex = 0;
  String _searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
      if (index == 0) {
        _selectedTabIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesCubit(MoviesRepo()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(MoviesRepo()),
        ),
        BlocProvider(
          create: (context) => AuthCubit(AuthRepository()),
        )
      ],
      child: Scaffold(
        drawer: Drawer(child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            String userName = '';
            if (state is AuthUserLoaded) {
              userName = state.user.email?.split('@').first ?? '';
            }
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: constbackground,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        userName,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.key_rounded),
                  title: const Text('Change Password'),
                  onTap: () {
                    Navigator.pushNamed(context, '/changepassword');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('LogOut'),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).signOut();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ],
            );
          },
        )),
        backgroundColor: constbackground,
        body: _selectedBottomNavIndex == 0
            ? _buildHomeContent(context)
            : const FavouriteScreen(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: constbackground,
            selectedItemColor: const Color(0xffF83758),
            currentIndex: _selectedBottomNavIndex,
            unselectedItemColor: Colors.white,
            onTap: _onBottomNavItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Favourites List',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 65, right: 26),
          child: AppTextFormField(
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
                if (_searchQuery.isEmpty) {
                  _pageController.jumpToPage(0);
                } else {
                  _pageController.jumpToPage(3);
                }
              });
            },
            color: Colors.grey[350],
            backgroundColor: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
            prefixIcon: const Icon(
              Icons.search,
              size: 24,
              color: Colors.white,
            ),
            hintText: 'Search Movie',
            controller: searchController,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(0, 'Popular'),
            _buildTabItem(1, 'Top Rating'),
            _buildTabItem(2, 'Trending'),
          ],
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            children: [
              const PopularView(),
              const TopRatedView(),
              const TrendingView(),
              SearchResultsView(query: _searchQuery),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(int index, String title) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Text(
        title,
        style: TextStyle(
          color: _selectedTabIndex == index
              ? const Color(0xffF83758)
              : Colors.grey.withOpacity(0.5),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}




// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final PageController _pageController = PageController();
//   int _selectedTabIndex = 0;
//   int _selectedBottomNavIndex = 0;
//   String _searchQuery = '';
//   final TextEditingController searchController = TextEditingController();

//   void _onTabSelected(int index) {
//     setState(() {
//       _selectedTabIndex = index;
//       print('Selected tab index: $_selectedTabIndex'); // Debugging line
//       _pageController.animateToPage(
//         index,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   void _onBottomNavItemTapped(int index) {
//     setState(() {
//       _selectedBottomNavIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => MoviesCubit(MoviesRepo()),
//         ),
//         BlocProvider(
//           create: (context) => SearchCubit(MoviesRepo()),
//         ),
//         BlocProvider(
//           create: (context) => AuthCubit(AuthRepository()),
//         )
//       ],
//       child: Scaffold(
//         drawer: Drawer(child: BlocBuilder<AuthCubit, AuthState>(
//           builder: (context, state) {
//             String userName = '';
//             if (state is AuthUserLoaded) {
//               userName = state.user.email?.split('@').first ?? '';
//             }
//             return ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 DrawerHeader(
//                   decoration: const BoxDecoration(
//                     color: constbackground,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircleAvatar(
//                         radius: 30,
//                         child: Icon(
//                           Icons.person,
//                           size: 40,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Text(
//                         userName,
//                         style: TextStyle(color: Colors.white),
//                       )
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.key_rounded),
//                   title: const Text('Change Password'),
//                   onTap: () {
//                     Navigator.pushNamed(context, '/changepassword');
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.logout),
//                   title: const Text('LogOut'),
//                   onTap: () {
//                     BlocProvider.of<AuthCubit>(context).signOut();
//                     Navigator.of(context).pushReplacementNamed('/login');
//                   },
//                 ),
//               ],
//             );
//           },
//         )),
//         backgroundColor: constbackground,
//         body: _selectedBottomNavIndex == 0
//             ? _buildHomeContent(context)
//             : const FavouriteScreen(),
//         bottomNavigationBar: Theme(
//           data: Theme.of(context).copyWith(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//           ),
//           child: BottomNavigationBar(
//             backgroundColor: constbackground,
//             selectedItemColor: const Color(0xffF83758),
//             currentIndex: _selectedBottomNavIndex,
//             unselectedItemColor: Colors.white,
//             onTap: _onBottomNavItemTapped,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.list),
//                 label: 'Favourites List',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHomeContent(BuildContext context) {
//     return Padding(
//       padding: _selectedTabIndex == 0
//           ? EdgeInsets.zero
//           : const EdgeInsets.only(left: 20, top: 65, right: 26),
//       child: Column(
//         children: [
//           Padding(
//             padding: _selectedTabIndex == 0
//                 ? const EdgeInsets.only(top: 65, left: 15, right: 15)
//                 : EdgeInsets.zero,
//             child: AppTextFormField(
//               onChanged: (query) {
//                 setState(() {
//                   _searchQuery = query;
//                   if (_searchQuery.isEmpty) {
//                     _pageController.jumpToPage(0);
//                   } else {
//                     _pageController.jumpToPage(3);
//                   }
//                 });
//               },
//               color: Colors.grey[350],
//               backgroundColor: Colors.grey.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12.0),
//               prefixIcon: const Icon(
//                 Icons.search,
//                 size: 24,
//                 color: Colors.white,
//               ),
//               hintText: 'Search Movie',
//               controller: searchController,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildTabItem(0, 'Popular'),
//               _buildTabItem(1, 'Top Rating'),
//               _buildTabItem(2, 'Trending'),
//             ],
//           ),
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   _selectedTabIndex = index;
//                   print('Page changed to: $index'); // Debugging line
//                 });
//               },
//               children: [
//                 const PopularView(),
//                 const TopRatedView(),
//                 const TrendingView(),
//                 SearchResultsView(query: _searchQuery),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabItem(int index, String title) {
//     return GestureDetector(
//       onTap: () => _onTabSelected(index),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: _selectedTabIndex == index
//               ? const Color(0xffF83758)
//               : Colors.grey.withOpacity(0.5),
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hatphi_test/provider/user_view_model.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/model/user_data_model.dart';
import '../../../src/pages.dart';
import '../../../utils/screen_utils.dart';
import '../../components/custom_btn.dart';


/// The Home widget serves as the main screen for displaying user data.
/// It utilizes Riverpod for state management and includes features such as
/// search, filtering, pagination, and pull-to-refresh functionality.
class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with SingleTickerProviderStateMixin {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1.0);
  double page = 0;
  // Mock user data for demonstration
  List<Map<String, String>> allUsers = [
    {
      'type': 'single',
      'name': 'Tabish Bin Tahir',
      'message': 'Hi Tabish, how are you doing?',
      'time': '1 hour ago',
    },
    {
      'type': 'group',
      'name': 'Group name',
      'message': 'Anna: Hi Tabish, how are you doing?',
      'time': '1 hour ago',
    },
    {
      'type': 'single',
      'name': 'Anna Paul',
      'message': 'Hi Tabish, how are you doing?',
      'time': '1 hour ago',
      'image': AppAsset.placeHolder,
    },
    {
      'type': 'single',
      'name': 'Tabish Bin Tahir',
      'message': 'Hi Tabish, how are you doing?',
      'time': '1 hour ago',
    },
    {
      'type': 'group',
      'name': 'Group name',
      'message': 'Anna: Hi Tabish, how are you doing?',
      'time': '1 hour ago',
    },
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(userViewModelProvider.notifier).fetchUsers().then((value){
        setState(() {
          ref.watch(userViewModelProvider.notifier).filteredUsers.addAll(ref.read(userViewModelProvider.notifier).users);
        });
      });
    });
    filteredUsersList = allUsers;

    /// Listen to page changes for animation or state updates
    _pageController.addListener(() {
      setState(() {
        page = _pageController.page!;
      });
    });
  }

  /// Handles navigation between tabs and applies filters accordingly
  void _navigate(int index) {
    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOut;
    /// Filters the user list based on the selected type ('all', 'group', 'single')
    switch (index) {
      case 0:
        _filterUser('all');
        break;
      case 1:
        _filterUser('group');
        break;
      case 2:
        _filterUser('single');
        break;
    }

    _pageController.animateToPage(index, duration: duration, curve: curve);
  }


  /// Filtered users list for displaying filtered results
  List<Map<String, String>> filteredUsersList = [];
  String selectedFilter = 'all';

  void _filterUser(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'all') {
        filteredUsersList = allUsers;
      } else {
        filteredUsersList =
            allUsers.where((users) => users['type'] == filter).toList();
      }
    });
  }

  /// Controller for pull-to-refresh functionality
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000),(){
      ref.watch(userViewModelProvider.notifier).fetchUsers();
    });
    _refreshController.refreshCompleted();
  }



  @override
  Widget build(BuildContext context) {
    final stateProvider = ref.watch(userViewModelProvider);
    final provider = ref.watch(userViewModelProvider.notifier);
    return Scaffold(
      appBar: appBar(context),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Skeletonizer(
          enabled: stateProvider.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                fillColor: AppColors.kLightGrey,
                isFilled: true,
                controller: provider.searchController,
                onChanged:(query){
                  setState(() {
                    provider.filteredUsers = provider.filterUsersByName(provider.users, query);
                  });

                },
                prefixIcon: AppAsset.search,
                hint: 'Search here',
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    _buildChip(
                      page,
                      selectedIndex: 0,
                      label: 'All',
                      onTap: () => _navigate(0),
                    ),
                    const Gap(10),
                    _buildChip(
                      page,
                      selectedIndex: 1,
                      label: 'Groups',
                      onTap: () => _navigate(1),
                    ),
                    const Gap(10),
                    _buildChip(
                      page,
                      selectedIndex: 2,
                      label: 'Unread',
                      onTap: () => _navigate(2),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) => ListView.builder(
                      itemCount: provider.filteredUsers.length,
                      itemBuilder: (context, index) {
                        final usersList = provider.filteredUsers[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: AppColors.kBlue,
                                foregroundColor: Colors.white,
                                icon: Icons.more_horiz,
                                label: 'More',
                              ),
                            ],
                          ),
                          child: Container(
                            height: fullHeight(context) * 0.071,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffF3F3F3),
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: Stack(
                                children: [_buildAvatar(context)],
                              ),
                              title: TextView(
                                text: usersList.name.toString(),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff0E0D1E),
                                fontSize: 15,
                              ),
                              subtitle: TextView(
                                text: usersList.email!,
                                color: AppColors.primaryTextColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              trailing: const TextView(
                                text: '1 hour',
                                color: AppColors.kBlue,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            )

                          ),
                        );
                      }),
                ),
              ),
              Center(
                child: CustomAppButton(
                  color: AppColors.kBlack,
                  isActive: true,
                  height: fullHeight(context) * 0.039,
                  width: 162,
                  title: 'Send new message',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(fullWidth(context) * 0.2),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(

        onTap: ()=>  ref.read(userViewModelProvider.notifier).fetchUsers() ,
        child: const Card(
          shape: CircleBorder(),
          elevation: 3,
          child: CircleAvatar(
            backgroundColor: AppColors.kBlue,
            radius: 40,
            child: Center(
                child: Icon(
              Icons.add,
              size: 40,
            )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    toolbarHeight: fullHeight(context) * 0.1,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.kLightGrey,
              child: SvgPicture.asset(
                AppAsset.menu,
                height: 11.3,
                width: 16,
              ),
            ),
            const Gap(15),
            const TextView(
              text: 'Home',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.kBlack,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBarBadges(
              context: context,
              label: 'Groups',
              image: AppAsset.persons,
            ),
            const Gap(15),
            _buildAppBarBadges(
              context: context,
              label: 'Contacts',
              image: AppAsset.contact,
            ),
            const Gap(15),
            _buildAppBarBadges(
                context: context,
                label: 'Settings',
                image: AppAsset.settings,
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ContactInfoPage()));
                }),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAppBarBadges(
    {required BuildContext context, label, image, onTap}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.kLightGrey,
          child: SvgPicture.asset(
            image,
            height: fullHeight(context) * 0.017,
          ),
        ),
      ),
      const Gap(10),
      TextView(
        text: label,
        fontWeight: FontWeight.w400,
        fontSize: fullHeight(context) * 0.01,
        color: AppColors.primaryTextColor,
      ),
    ],
  );
}

Widget _buildChip(index, {label, selectedIndex, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Chip(
      backgroundColor: index == selectedIndex
          ? AppColors.kBlue.withOpacity(0.15)
          : AppColors.kLightGrey,
      label: TextView(
        text: label,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: index == selectedIndex
            ? AppColors.kBlue
            : AppColors.primaryTextColor,
      ),
    ),
  );
}

Widget _buildAvatar(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.push(Constants.contactScreen);
    },
    child: Stack(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(AppAsset.person),
          backgroundColor: AppColors.kLightGrey,
          child: SvgPicture.asset(AppAsset.person)
        ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(AppAsset.stackedImage),
          ),
      ],
    ),
  );
}

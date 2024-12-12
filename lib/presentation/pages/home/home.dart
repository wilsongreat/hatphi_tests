import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../src/pages.dart';
import '../../../utils/screen_utils.dart';
import '../../components/custom_btn.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1.0);
  double page = 0;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> allChats = [
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
    filteredChats = allChats;

    _pageController.addListener(() {
      setState(() {
        page = _pageController.page!;
      });
    });
  }

  void _navigate(int index) {
    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOut;

    switch (index) {
      case 0:
        _filterChats('all');
        break;
      case 1:
        _filterChats('group');
        break;
      case 2:
        _filterChats('single');
        break;
    }

    _pageController.animateToPage(index, duration: duration, curve: curve);
  }

  List<Map<String, String>> filteredChats = [];
  String selectedFilter = 'all';

  void _filterChats(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'all') {
        filteredChats = allChats;
      } else {
        filteredChats =
            allChats.where((chat) => chat['type'] == filter).toList();
      }
    });
  }

  void _searchChats(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredChats = allChats
            .where((chat) =>
                chat['type'] == selectedFilter || selectedFilter == 'all')
            .toList();
      } else {
        filteredChats = filteredChats
            .where((chat) =>
                chat['name']!.toLowerCase().contains(query.toLowerCase()) ||
                chat['message']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            fillColor: AppColors.kLightGrey,
            isFilled: true,
            controller: _searchController,
            onChanged: _searchChats,
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
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];
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
                            children: [_buildAvatar(chat, context)],
                          ),
                          title: TextView(
                            text: chat['name']!,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff0E0D1E),
                            fontSize: 15,
                          ),
                          subtitle: TextView(
                            text: chat['message']!,
                            color: AppColors.primaryTextColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          trailing: TextView(
                            text: chat['time']!,
                            color: AppColors.kBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: index * 100))
                            .slideX(begin: 1.0, duration: 300.ms),
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
      floatingActionButton: const Card(
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

Widget _buildAvatar(Map<String, String> chat, BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.push(Constants.contactScreen);
    },
    child: Stack(
      children: [
        CircleAvatar(
          backgroundImage:
              chat.containsKey('image') ? AssetImage(chat['image']!) : null,
          backgroundColor: AppColors.kLightGrey,
          child: chat['type'] == 'single' && !chat.containsKey('image')
              ? SvgPicture.asset(AppAsset.person)
              : chat['type'] == 'group' && !chat.containsKey('image')
                  ? SvgPicture.asset(AppAsset.groupIcon)
                  : const SizedBox.shrink(),
        ),
        if (chat['type'] == 'group')
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(AppAsset.stackedImage),
          ),
      ],
    ),
  );
}

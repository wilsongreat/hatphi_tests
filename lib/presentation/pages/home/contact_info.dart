import 'package:hatphi_test/presentation/components/custom_btn.dart';
import 'package:hatphi_test/src/pages.dart';
import 'package:hatphi_test/utils/screen_utils.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          stackedHeader(context),
          const Gap(80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  width: fullWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextView(
                        text: 'Tabish Bin Tahir',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(5),
                      SvgPicture.asset(AppAsset.checkIcon)
                    ],
                  ),
                ),
                const TextView(
                  text: 'tabish_m2m',
                  fontSize: 15,
                ),
                const Gap(10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.kBlue.withOpacity(.08)),
                  child: const TextView(
                    text: 'Specialty',
                    color: AppColors.kBlue,
                  ),
                ),
                const Gap(40),
                infoTile(label: 'Business Name', info: 'Mind2Matter'),
                infoTile(label: 'Job Title', info: 'UI UX Designer'),
                infoTile(label: 'Type of provider', info: 'Provider type'),
                infoTile(label: 'Zip Code', info: '10001'),
                const Gap(30),
                Center(
                  child: CustomAppButton(
                    color: AppColors.kBlack,
                    isActive: true,
                    height: fullHeight(context) * 0.049,
                    width: fullWidth(context) * .7,
                    title: 'Send a message',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(30),
                const Align(
                  alignment: Alignment.topLeft,
                  child: TextView(
                    text: 'Block Contact',
                    fontSize: 15,
                  ),
                )
              ],
            ),
          )
        ],
      ).animate().slideX(end: 0, duration: 300.ms).fade(duration: 500.ms),
    );
  }

  Widget stackedHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: fullHeight(context) * .28,
          width: fullWidth(context),
          color: AppColors.kBlack,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Gap(30),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                      color: AppColors.kWhite,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Gap(20.0),
                  const TextView(
                    text: 'Contact info',
                    color: AppColors.kWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 200,
          left: 150,
          child: CircleAvatar(
            radius: 63.5,
            backgroundImage: AssetImage(
              AppAsset.placeHolder,
            ),
          ).animate().rotate(duration: 500.ms),
        )
      ],
    );
  }

  Widget infoTile({required String label, info}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: label,
                fontSize: 15,
              ),
              TextView(
                text: info,
                fontSize: 15,
              ),
            ],
          ),
          Gap(10),
          Divider(
            thickness: .5,
            color: AppColors.kGrey,
          )
        ],
      ),
    );
  }
}

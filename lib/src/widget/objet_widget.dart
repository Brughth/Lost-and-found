import 'package:flutter/material.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

class ObjetWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String? userImage;
  final String username;
  final String? usersubname;
  final String createAd;

  const ObjetWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.userImage,
    required this.usersubname,
    required this.username,
    required this.createAd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                if (userImage == null)
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 25,
                  ),
                if (userImage != null)
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 26,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userImage!),
                      radius: 25,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "$username ",
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                            children: [
                              if (usersubname != null)
                                TextSpan(
                                  text: usersubname,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  DateFormat.yMMMd()
                                      .format(DateTime.parse(createAd)),
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: AppColors.primary.withOpacity(.6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: ReadMoreText(
              description,
              trimLines: 2,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
              ),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              lessStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
          ),
          SizedBox(
            height: screenHeigth * .01,
          ),
          Container(
            height: screenHeigth * .3,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.share,
                  color: AppColors.primary,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("put it back"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

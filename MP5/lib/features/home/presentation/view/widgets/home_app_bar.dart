import 'package:flutter/material.dart';
import 'package:mp5/core/utils/extensions.dart';
import 'package:mp5/features/home/data/repos/home_repo_impl.dart';
import '../../../../../core/utils/functions/show_search.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({
    super.key,
  });
  final HomeRepoImpl homeRepoImpl = HomeRepoImpl(); // Example instantiation

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Spacer(),
          CustomButton(
            icon: Icons.search,
            onTap: () {
              showSearchBar(context, homeRepoImpl);
            },
          ),
          10.0.spaceX,
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20.0,
        backgroundColor: Colors.grey[300],
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}

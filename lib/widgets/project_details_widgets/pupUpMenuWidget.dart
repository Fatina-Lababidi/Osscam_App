import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/delete_project_bloc/delete_project_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/get_projects_page.dart';
import 'package:page_transition/page_transition.dart';

class PopUpMenuWidget extends StatefulWidget {
  final int projectId;
  const PopUpMenuWidget({
    super.key,
    required this.projectId,
  });

  @override
  State<PopUpMenuWidget> createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {
  bool _isSnackBarVisible = false;

  void _showSnackBar(BuildContext context, String message, Color backgroundColor) {
    if (!_isSnackBarVisible) {
      _isSnackBarVisible = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: backgroundColor,
          duration: Duration(seconds: 2),
        ),
      ).closed.then((_) {
        _isSnackBarVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Builder(builder: (context) {
      return PopupMenuButton<int>(
        onSelected: (value) {
          switch (value) {
            case 1:
              showDialog(
                barrierDismissible: false,
                barrierColor: AppColors.primaryColor.withOpacity(0.3),
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.deleteCardColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.05,
                          left: screenWidth * 0.03,
                          right: screenWidth * 0.03,
                          bottom: screenHeight * 0.02,
                        ),
                        child: Container(
                          width: screenWidth * 0.72,
                          height: screenHeight * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: BlocConsumer<DeleteProjectBloc, DeleteProjectState>(
                            listener: (context, state) {
                              if (state is SuccessDeleteProject) {
                                _showSnackBar(context, 'Successfully deleted...', AppColors.cardGreenColor);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const GetProjectsPage(),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                                context.read<DeleteProjectBloc>().add(RefreshProjects());
                              } else if (state is FailedDeleteProject) {
                                _showSnackBar(context, 'Error, please try again...', AppColors.deleteCardColor);
                                context.read<DeleteProjectBloc>().add(RefreshProjects());
                              } else if (state is OfflineDeleteProject) {
                                _showSnackBar(context, 'Offline, please try later...', AppColors.dropTextColor);
                                context.read<DeleteProjectBloc>().add(RefreshProjects());
                              }
                            },
                            builder: (context, state) {
                              if (state is DeleteProjectInitial) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Are you sure you want to ',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      const Text(
                                        'delete this project?',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<DeleteProjectBloc>().add(DeleteProject(
                                                    projectId: widget.projectId,
                                                  ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: AppColors.sureButtonColor,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: screenHeight * 0.01,
                                                  horizontal: screenWidth * 0.01,
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Yes, I am sure',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is FailedDeleteProject || state is OfflineDeleteProject) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Something went wrong...',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: AppColors.deleteCardColor,
                                        ),
                                      ),
                                      const Text(
                                        'Please try again.',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: 5),
                                    const CircularProgressIndicator(
                                      color: AppColors.deleteCardColor,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
              break;
            case 2:
              // Edit: Navigate to the edit page or perform edit action
              break;
            case 3:
              // Copy ID
              Clipboard.setData(ClipboardData(text: widget.projectId.toString()));
              showDialog(
                barrierDismissible: false,
                context: context,
                barrierColor: AppColors.primaryColor.withOpacity(0.3),
                builder: (context) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: AnimatedPrompt(
                          title: 'Copied ID',
                          subTitle: 'You can paste it whenever you want!',
                          child: Icon(
                            Icons.check,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
              break;
          }
        },
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: AppColors.buttonColor,
        popUpAnimationStyle: AnimationStyle(
          curve: Curves.easeInOut,
          duration: .2.seconds,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: AppColors.dropTextColor,
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(fontSize: 10, color: AppColors.dropTextColor),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.mode_edit_outline_rounded,
                      color: AppColors.dropTextColor,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(fontSize: 10, color: AppColors.dropTextColor),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                Icon(
                  Icons.copy,
                  color: AppColors.dropTextColor,
                ),
                Text(
                  "Copy ID",
                  style: TextStyle(fontSize: 10, color: AppColors.dropTextColor),
                ),
              ],
            ),
          ),
        ],
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.primaryColor,
          ),
        ),
      );
    });
  }
}

class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget child;
  const AnimatedPrompt({
    super.key,
    required this.title,
    required this.subTitle,
    required this.child,
  });

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _yAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.23),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _iconScaleAnimation = Tween<double>(begin: 7, end: 6)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _containerScaleAnimation = Tween<double>(begin: 2.0, end: 0.4)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.textFieldColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            minHeight: 50,
            maxHeight: MediaQuery.of(context).size.height * 0.3,
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.subTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: SlideTransition(
                  position: _yAnimation,
                  child: ScaleTransition(
                    scale: _containerScaleAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: ScaleTransition(
                        scale: _iconScaleAnimation,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

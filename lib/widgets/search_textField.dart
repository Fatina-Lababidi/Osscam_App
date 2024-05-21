import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/get_projects_model.dart';
import 'package:osscam/pages/get_projects_page.dart';


class SearchTextField extends StatefulWidget {
  //final String hintText;
  List<ProjectsModel> data;
   SearchTextField({
    Key? key, required this.data
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(left: 5, top: 2),
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        _isFocused ? Colors.white : AppColors.textFieldColor),
                borderRadius: BorderRadius.circular(19),
                color: _isFocused ? Colors.white : AppColors.textFieldColor,
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                   List<ProjectsModel> newResult = [];
                    List<ProjectsModel> projects = widget.data;
                    // print(projects);
                    projects.forEach((element) {
                      if (element.name.contains(value)) {
                        newResult.add(element);
                      }
                    });
                    result.value = newResult;
                  });
                },
                obscureText: false,
                style: TextStyle(color: AppColors.inputTextColor),
                // showCursor: ,
                cursorColor: AppColors.textFieldColor,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  suffixIcon: _isFocused
                      ? const Icon(
                          Icons.search,
                          color: Color(0xff77C1C1),
                          size: 30,
                        )
                      : SizedBox(
                          width: 20,
                          height: 10,
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                  hintText: _isFocused ? "Search .." : "All projects",
                  hintStyle: TextStyle(
                      fontSize: 25,
                      color:
                          _isFocused ? AppColors.textFieldColor : Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          );
        });
      },
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_state.dart';
import 'package:tastytable/features/settings/presentation/widgets/settings_user_name_textfeild.dart';
import 'package:tastytable/features/settings/presentation/widgets/shimmer/stack_user_name_and_shimmer.dart';

Widget showUserName() {
  return BlocBuilder<UserNameBloc,UserNameState>(builder: (context, state) {
      if(state is UserNameFailure){
        return StackedUserNameAndShimmer(); 
      }
      String userName='';
      if(state is UserNameSuccess){
        userName=state.user_name;
      }
      return SettingsUserNameTextfeild(userName: userName);
  },);
}
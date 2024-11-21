import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

Widget authLoadingOnButtonClick(){
  return const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: LoadingIndicator(
                              colors: [Colors.black],
                              strokeWidth: 2,
                              indicatorType: Indicator.ballPulse,
                            ),
                          ),
                        );
}
import 'dart:isolate';
import 'dart:ui';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constant/app_string.dart';


late Dio dio;
late GetStorage box;
bool forceLogout = false;


class AppConstant {
  AppConstant._();

  static const isLogin = 'isLogin';
  static const userProfile = 'userProfile';


  static const deviceInfoBox = 'deviceInfoBox';
  static const userLoginData = 'userLoginData';
  static const userToken = 'userToken';

  static const isTutorialDone = 'isTutorialDone';
  static const isWelcomeDialogDone = 'isWelcomeDialogDone';

  static const isSocialLogin = 'isSocialLogin';
  static const appStoreVersion = 'App-Store-Version';
  static const appDeviceModel = 'App-Device-Model';
  static const appOsVersion = 'App-Os-Version';
  static const appStoreBuildNumber = 'App-Store-Build-Number';
  static const authToken = 'Auth-Token';
  static const accessToken = 'Access-Token';
  static const awsBucketName = 'yur-invtd-test';
  static const awsPoolId = 'us-east-1:f25ae994-d3f9-4557-afa6-04ca25c02dbf';
  static const doRegion = 'sfo3';
  static const doAccessKey = 'DO00XXHUVPMCBCLT6FDM';
  static const doSecretKey = '0AWLUr9CITp3lRKrLEEpXVSSrC+vC1PBgF9mjKe+inc';
  static const doProjectName = 'yourinvitedpro';
  static const doProjectNameDev = 'yoursinvited';
  static const userNotFound = 1;
  static const userFound = 2;
  static const invitedPartyId = 'invitedPartyId';
  static const invitedPartyUserToken = 'invitedPartyUserToken';
  static const invitedPartyIsActive = 'invitedPartyIsActive';

  static String contactUrl = 'https://yurinvtd.com/contact/';
  static String errorText = somethingWentWrong;

  static List<Map<String, dynamic>> gettingStartedList = [
    {
      'index': 0,
      'text':
          '<Start a party> to create a shared photo album for all your friends to join.',
      'icon': '🎉',
    },
    {
      'index': 1,
      'text': 'Everyone will have 7 days to share their photos.',
      'icon': '⏳',
    },
    {
      'index': 2,
      'text':
          'All event photos will be saved to view anytime in <Past Galleries.>',
      'icon': '💾',
    },
    {
      'index': 3,
      'text':
          'Save all your <Favorites> and download directly to your own device.',
      'icon': '❤️',
    },
    // 4: 'Ready to get started? Head over to the <shop> for party credits.'
  ];
}

import 'package:flutter/cupertino.dart';
import 'package:social_app/Components/cache_helper.dart';

double screenWidth(context) => MediaQuery.of(context).size.width;

double screenHeight(context) => MediaQuery.of(context).size.height;

String uId = CacheHelper.getData(key: 'uId') ?? '';

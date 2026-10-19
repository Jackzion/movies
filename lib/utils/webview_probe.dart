
import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

/// 探测 webview2 是否支持
/// 成功返回 true；失败返回 false 并打日志。
Future<bool> probeHeadlessWebview() async{
  HeadlessWebview? wv;
  try{
    wv = HeadlessWebview();
    await wv.run();
    debugPrint('[WebviewProbe] OK');
    return true;
  }catch(e){
    debugPrint('[WebviewProbe] Error: $e');
    return false;
  }finally{
    try{
      wv?.dispose();
    }catch (_) {}
  }
}
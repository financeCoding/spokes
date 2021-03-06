/**
import 'package:spokes/spokes.dart' as Spokes;
export 'package:spokes/spokes.dart' show SpokesModel, SpokesController, SpokesRoutes, SpokesUrl, SpokesRequest;

import 'dart:io';
export 'dart:io';
import 'dart:async';
import '../settings.dart';
export '../settings.dart';

main(List port){

  if(port.isNotEmpty){
    Spokes.port = int.parse(port[0]);
  }

  Directory scripts = new Directory(Directory.current.path+Platform.pathSeparator+"public"+Platform.pathSeparator+"scripts");

  //compile javascript at runtime
  List initialScripts = scripts.listSync(recursive:true);
  initialScripts.forEach((data){
    if(data.path.indexOf(".dart") > 0 && data.path.indexOf(".js") < 0 ){
      print("compiling for ${data.path}");
      //recompile
      Process.run(spokesOptions["dart2js"], ["-o",data.path+".js",data.path]).then((result){
        if(result.exitCode == 0){
          print("${data.path} successfully compiled to javascript");
          return true;
        }else{
          print("error compiling ${data.path} to js");
        }
      });
    }
  });

  Spokes.middleWares = middleWares;
  Spokes.BASE_PATH = BASE_PATH;
  Spokes.PUBLIC_PATH = PUBLIC_PATH;
  Spokes.templateEngine = templateEngine;
  print("starting server");
  Spokes.start(certificateName);
  Spokes.spokesOptions = spokesOptions;



  Stream scriptStream = scripts.watch(recursive:true);

  scriptStream.listen((data){
    if(data.isDirectory == false && (data.type == 2)){
      //file was created or modified
      if(data.path.indexOf(".dart") > 0 && data.path.indexOf(".js") < 0 ){
        print("compiling for ${data.path}");
        //recompile
        Process.run(spokesOptions["dart2js"], ["-o",data.path+".js",data.path]).then((result){
          if(result.exitCode == 0){
            print("${data.path} successfully compiled to javascript");
            return true;
          }else{
            print("error compiling ${data.path} to js");
          }
        });
      }
    }else if(data.type == 4 && data.path.indexOf(".dart") > 0 && data.path.indexOf(".js") < 0){
      //file was deleted
      File js = new File(data.path+".js");
      if(js.existsSync()){
        js.delete();
      }
      File deps = new File(data.path+".js.deps");
      if(js.existsSync()){
        deps.delete();
      }
      File map = new File(data.path+".js.map");
      if(map.existsSync()){
        map.delete();
      }
      File precomiled = new File(data.path+".precompiled.js");
      if(precomiled.existsSync()){
        precomiled.delete();
      }
    }
  });


}
**/
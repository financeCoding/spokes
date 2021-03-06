part of spokes;

class SpokesController {

  render(SpokesRequest request, [Map params,String template]){
    var path = request.uri.path;
    if(template !=null){
      path = template;
    }
     templateEngine.render(path,params).then((msg){
      request.response.write(msg);
      request.response.close();
    }).catchError((error){
       request.response.write(error);
       });
  }

  serve(SpokesRequest request,[String fileName]){
    String path = BASE_PATH+request.uri.path;
    if(fileName != null){
      path = BASE_PATH+fileName;
    }
    print("trying to serve $path");
    return new File(path).openRead().pipe(request.request.response).then((d){request.request.response.close();});
  }

  sendJSON(SpokesRequest request,var jsonData){
    request.response..headers.set(HttpHeaders.CONTENT_TYPE, 'application/json');
    request.response..headers..write(JSON.encode(jsonData))..close();

  }
}
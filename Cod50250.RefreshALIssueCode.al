codeunit 50350 RefreshALIssueCode
{
    trigger OnRun()
    begin
        
    end;
    
    procedure Refresh()
    var
        ALIssue : Record ALIssue;
        Httpclient : HttpClient;
        ResponseMessage : HttpResponseMessage;
        JsonToken : JsonToken;
        JsonObject : JsonObject;
        JsonArray : JsonArray;
        JsonText : Text;
        i : Integer;
    begin
        ALIssue.DeleteAll();
        //simple web service call
        Httpclient.DefaultRequestHeaders().Add('User-Agent','Dynamics 365');
        if not Httpclient.Get('https://api.github.com/repos/Microsoft/AL/issues',
                              ResponseMessage) then
           Error('The Call to the Web Service Failed');

        if not ResponseMessage.IsSuccessStatusCode() then   
          Error('The web service returned an error message:\\' + 
                'Status code: %1' + 
                'Description: %2',
                ResponseMessage.HttpStatusCode(),
                ResponseMessage.ReasonPhrase());    

        ResponseMessage.Content().ReadAs(JsonText);
        
        // Process JSON response
        if not JsonArray.ReadFrom(JsonText) then
            Error('Invalid response, expected an JSON array as root object');

        
        for i := 0 to JsonArray.Count() - 1 do begin

            JsonArray.Get(i,JsonToken);

            JsonObject := JsonToken.AsObject();

            ALIssue.init();

            if not JsonObject.Get('id',JsonToken) then
                error('Could not find a token with key %1');

            ALIssue.id := JsonToken.AsValue().AsInteger();
            ALIssue.number := GetJsonToken(JsonObject,'number').AsValue().AsInteger();
            ALIssue.title := copystr(GetJsonToken(JsonObject,'title').AsValue().AsText(),1,250);
            ALIssue.created_at := GetJsonToken(JsonObject,'created_at').AsValue().AsDateTime();
            ALIssue.user := copystr(SelectJsonToken(JsonObject,'$.user.login').AsValue().AsText(),1,50);
            ALIssue.state := copystr(GetJsonToken(JsonObject,'state').AsValue().AsText(),1,30);
            ALIssue.html_url := copystr(GetJsonToken(JsonObject,'html_url').AsValue().AsText(),1,250);
            ALIssue.Insert();
        end;
    end;

    procedure GetJsonToken(JsonObject:JsonObject;TokenKey:Text)JsonToken:JsonToken;
    begin
        if not JsonObject.Get(TokenKey,JsonToken) then
          Error('Could not find a token with key %1',TokenKey);
    end;

    procedure SelectJsonToken(JsonObject:JsonObject;Path:Text)JsonToken:JsonToken;
    begin
      if not JsonObject.SelectToken(Path,JsonToken) then
        Error('Could not find a token with path %1',Path)        
    end;

}
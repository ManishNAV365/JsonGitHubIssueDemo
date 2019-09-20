table 50250 ALIssue
{
   Caption = 'ALIssues';
   DataClassification = CustomerContent;

    fields

    {

        field(1;id;Integer)
        {  
            Caption = 'ID';
            DataClassification = CustomerContent;
        }

        field(2;number;Integer)

        {

            Caption = 'Number';
            DataClassification = CustomerContent;
        }

        field(3;title;text[250])

        {

            Caption = 'Title';
            DataClassification = CustomerContent;

        }

        field(5;"created_at";DateTime)

        {

            Caption = 'Created at';
            DataClassification = CustomerContent;

        }

        field(6;user;text[50])
        {
            Caption = 'User';
            DataClassification = CustomerContent;
        }

        field(7;state;text[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }

        field(8;html_url;text[250])
        {
            Caption = 'URL';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK;id)
        {
            Clustered = true;
        }
    }

    procedure RefreshIssues();
    var
        RefreshALIssues :Codeunit RefreshALIssueCode;
    begin
        RefreshALIssues.Refresh();
    end;
}
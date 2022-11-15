table 50103 "CLIP Course Ledger Entry"
{
    Caption = 'Course Ledger Entry', Comment = 'ESP="Mov. curso"';
    DrillDownPageID = "CLIP Course Ledger Entries";
    // LookupPageID = "CLIP Course Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.', Comment = 'ESP="Nº mov."';
            DataClassification = SystemMetadata;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'ESP="Nº documento"';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date', Comment = 'ESP="Fecha registro"';
        }
        field(5; "Course No."; Code[20])
        {
            Caption = 'Course No.', Comment = 'ESP="Nº curso"';
            TableRelation = "CLIP Course";
        }
        field(6; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            TableRelation = "CLIP Course Edition";
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description', Comment = 'ESP="Descripción"';
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'ESP="Cantidad"';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price', Comment = 'ESP="Precio unitario"';
        }
        field(16; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price', Comment = 'ESP="Precio total"';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Course No.", "Posting Date")
        {
        }
        key(Key5; "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Document No.", "Posting Date")
        {
        }
    }

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;

    procedure CopyFromCourseJournalLine(CourseJournalLine: Record "CLIP Course Journal Line")
    begin
        Rec."Document No." := CourseJournalLine."Document No.";
        Rec."Posting Date" := CourseJournalLine."Posting Date";
        Rec."Course No." := CourseJournalLine."Course No.";
        Rec."Course Edition" := CourseJournalLine."Course Edition";
        Rec.Description := CourseJournalLine.Description;
        Rec.Quantity := CourseJournalLine.Quantity;
        Rec."Unit Price" := CourseJournalLine."Unit Price";
        Rec."Total Price" := CourseJournalLine."Total Price";

        OnAfterCopyFromCourseJournalLine(Rec, CourseJournalLine);
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCopyFromCourseJournalLine(var CourseLedgerEntry: Record "CLIP Course Ledger Entry"; CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;
}
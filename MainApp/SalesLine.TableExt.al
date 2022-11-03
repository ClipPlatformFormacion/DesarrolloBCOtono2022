tableextension 50100 "CLIP Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("CLIP Course")) "CLIP Course";
        }
        field(50100; "CLIP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "CLIP Course Edition".Edition where("Course No." = field("No."));

            trigger OnValidate()
            begin
                CheckCourseEditionMaxStudents();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CheckCourseEditionMaxStudents();
            end;
        }
    }

    local procedure CheckCourseEditionMaxStudents()
    var
        CourseEdition: Record "CLIP Course Edition";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        SoldQuantity: Decimal;
        MaxStudentsExceededMsg: Label 'The current sale for course %1 edition %2 will exceed the maximum number of students: %3', comment = 'ESP="La venta actual para el curso %1 edición %2 superará el número máximo de alumnos: %3"';
    begin
        if Rec.Type <> Rec.Type::"CLIP Course" then
            exit;
        if Rec."CLIP Course Edition" = '' then
            exit;
        if Rec.Quantity = 0 then
            exit;

        CourseEdition.Get(Rec."No.", Rec."CLIP Course Edition");

        CourseLedgerEntry.SetRange("Course No.", Rec."No.");
        CourseLedgerEntry.SetRange("Course Edition", Rec."CLIP Course Edition");
        if CourseLedgerEntry.FindSet() then
            repeat
                SoldQuantity := SoldQuantity + CourseLedgerEntry.Quantity;
            until CourseLedgerEntry.Next() = 0;

        if SoldQuantity + Rec.Quantity > CourseEdition."Max. Students" then
            Message(MaxStudentsExceededMsg, Rec."No.", Rec."CLIP Course Edition", CourseEdition."Max. Students");
    end;
}